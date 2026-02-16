//
//  OnboardingViewModel.swift
//  travel
//
//  Collects user-supplied data across the onboarding flow (controllers 1–4 +
//  profile picture upload) and POSTs a registration request to the backend once
//  the user taps "Next" on the final screen.
//
//  Threading: all @Published mutations are always on the main thread because
//  this class is @MainActor.
//
//  Usage:
//    1. In WelcomeController4.googleButtonTapped, after signIn succeeds,
//       inject an instance via .environmentObject() when pushing OnboardingController1.
//    2. Each onboarding view writes to the shared instance via @EnvironmentObject.
//    3. OnboardingProfile calls `register()` and navigates to ExploreRides on success.
//

import Foundation
import SwiftUI

// MARK: - Registration request DTO (mirrors backend's POST /user/register body)

private struct RegistrationRequest: Encodable {
    let name: String
    let email: String
    let phoneNumber: String
    let pronouns: String
    let grade: String        // mapped from school/year field
    let location: String     // mapped from school location
    let profilePicURL: String
    // Backend sets rating, numRatings, loudness, musicPreference, funFact to defaults
}

// MARK: - OnboardingViewModel

@MainActor
final class OnboardingViewModel: ObservableObject {

    // MARK: - Collected fields (bound to individual onboarding screens)

    @Published var name: String = ""
    @Published var school: String = ""       // → location on User
    @Published var pronouns: String = ""
    @Published var phoneNumber: String = ""
    @Published var profilePicURL: String = ""

    // MARK: - Registration state

    @Published var isRegistering: Bool = false
    @Published var registrationError: String?

    // MARK: - Public API

    /// Call from OnboardingProfile after the user completes the final step.
    /// On success, UserManager is populated with the created User and
    /// AuthManager.isAuthenticated is already true (set during signIn) so
    /// RootView will automatically route to ExploreRides.
    func register() async {
        guard !name.isEmpty else {
            registrationError = "Please enter your name before continuing."
            return
        }

        isRegistering = true
        registrationError = nil
        defer { isRegistering = false }

        let email = UserManager.shared.user.email   // populated by AuthManager.signIn
        let body = RegistrationRequest(
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            pronouns: pronouns,
            grade: "",              // not collected in current onboarding screens
            location: school,
            profilePicURL: profilePicURL
        )

        do {
            let created: User = try await APIClient.shared.request(
                "/user/register",
                method: "POST",
                body: body
            )
            UserManager.shared.user = created
            UserManager.shared.saveUserToStorage(created)
        } catch let error as APIError {
            registrationError = error.errorDescription
        } catch {
            registrationError = error.localizedDescription
        }
    }
}
