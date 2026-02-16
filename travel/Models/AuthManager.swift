//
//  AuthManager.swift
//  travel
//
//  Single source of truth for authentication state.
//
//  Usage:
//    1. On Google Sign-In success, call:
//         try await AuthManager.shared.signIn(withGoogleIdToken: idTokenString)
//    2. Observe `isAuthenticated` in the root SwiftUI view to gate navigation.
//    3. Call `AuthManager.shared.signOut()` to log the user out.
//

import Foundation
import Security
import SwiftUI

// MARK: - Auth response DTO

private struct AuthResponse: Decodable {
    struct UserSummary: Decodable {
        let id: Int
        let name: String
        let email: String
        let profilePicURL: String
    }
    let token: String
    let user: UserSummary
}

// MARK: - AuthManager

@MainActor
final class AuthManager: ObservableObject {

    static let shared = AuthManager()
    private init() {
        isAuthenticated = token != nil
    }

    @Published var isAuthenticated: Bool = false
    /// True when the JWT is valid but the user has not yet completed onboarding.
    /// RootView uses this to route to the onboarding flow instead of ExploreRides.
    @Published var needsOnboarding: Bool = false
    @Published var authError: String?

    // MARK: - Sign In

    /// Call this immediately after receiving a Google ID token from Google Sign-In SDK.
    /// Verifies the token with the backend, stores the JWT, and fetches the full user profile.
    /// Sets `needsOnboarding = true` if the profile is incomplete (new user).
    func signIn(withGoogleIdToken idToken: String) async {
        authError = nil
        do {
            // 1. Exchange Google ID token for our JWT + user summary
            let authResponse: AuthResponse = try await APIClient.shared.request(
                "/auth/google",
                method: "POST",
                body: ["idToken": idToken]
            )

            // 2. Persist JWT in Keychain (must come before isAuthenticated = true
            //    so that APIClient can attach the Bearer header on the next call)
            saveToken(authResponse.token)

            // 3. Fetch the full User entity so UserManager has all fields
            let fullUser: User = try await APIClient.shared.request(
                "/user/\(authResponse.user.id)"
            )
            UserManager.shared.user = fullUser
            UserManager.shared.saveUserToStorage(fullUser)

            // 4. Determine whether onboarding is still needed.
            //    A new user will have an empty name until they complete the flow.
            needsOnboarding = fullUser.name.trimmingCharacters(in: .whitespaces).isEmpty

            // 5. isAuthenticated flips last — this is the signal RootView listens to.
            //    Everything above must succeed before we expose auth state.
            isAuthenticated = true

        } catch let error as APIError {
            authError = error.errorDescription
            isAuthenticated = false
        } catch {
            authError = error.localizedDescription
            isAuthenticated = false
        }
    }

    // MARK: - Sign Out

    func signOut() {
        deleteToken()
        isAuthenticated = false
        UserManager.shared.clearUser()
    }

    // MARK: - Token access

    nonisolated var token: String? {
        Keychain.read(key: KeychainKeys.jwtToken)
    }

    // MARK: - Private Keychain helpers

    private func saveToken(_ token: String) {
        Keychain.save(key: KeychainKeys.jwtToken, value: token)
    }

    private func deleteToken() {
        Keychain.delete(key: KeychainKeys.jwtToken)
    }
}

// MARK: - Keychain wrapper

private enum KeychainKeys {
    static let jwtToken = "com.stugo.jwt"
}

private enum Keychain {

    static func save(key: String, value: String) {
        guard let data = value.data(using: .utf8) else { return }

        let query: [CFString: Any] = [
            kSecClass:       kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData:   data
        ]

        SecItemDelete(query as CFDictionary)   // remove stale entry if any
        SecItemAdd(query as CFDictionary, nil)
    }

    static func read(key: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass:            kSecClassGenericPassword,
            kSecAttrAccount:      key,
            kSecReturnData:       true,
            kSecMatchLimit:       kSecMatchLimitOne
        ]

        var result: AnyObject?
        guard SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data else { return nil }

        return String(data: data, encoding: .utf8)
    }

    static func delete(key: String) {
        let query: [CFString: Any] = [
            kSecClass:       kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
