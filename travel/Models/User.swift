//
//  User.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.
//


import SwiftUI
import Combine

// Your User Model
struct User: Identifiable, Decodable, Equatable, Encodable {
    var id: Int
    var name: String
    var rating: Double
    var numRatings: Int
    var profilePicURL: String
    var loudness: Int // 1-5
    var musicPreference: String
    var funFact: String
    var phoneNumber: String
    var pronouns: String
    var grade: String
    var location: String
    var email: String
    // Populated separately via /api/v1/trips/user/{id}/offers and /requests
    var rideOffers: [TripInfo] = []
    var rideRequests: [TripInfo] = []

    // Exclude rideOffers/rideRequests from JSON encoding/decoding —
    // the backend User entity does not contain these fields.
    enum CodingKeys: String, CodingKey {
        case id, name, rating, numRatings, profilePicURL, loudness,
             musicPreference, funFact, phoneNumber, pronouns, grade,
             location, email
    }

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

@MainActor
class UserManager: ObservableObject {
    static let shared = UserManager()
    private init() {
        user = UserManager.getUserFromLocalStorage() ?? User(
            id: 0, name: "", rating: 0, numRatings: 0, profilePicURL: "",
            loudness: 3, musicPreference: "", funFact: "", phoneNumber: "",
            pronouns: "", grade: "", location: "", email: ""
        )
    }

    @Published var user: User

    // Fetch from backend and update cache
    func loadUserData(userId: Int) {
        Task {
            do {
                let fetched: User = try await APIClient.shared.request("/user/\(userId)")
                user = fetched
                saveUserToStorage(fetched)
            } catch {
                print("UserManager: failed to load user \(userId) — \(error.localizedDescription)")
            }
        }
    }

    // Called by AuthManager after sign-in
    func saveUserToStorage(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "storedUser")
        }
    }

    // Called by AuthManager on sign-out
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: "storedUser")
        user = User(
            id: 0, name: "", rating: 0, numRatings: 0, profilePicURL: "",
            loudness: 3, musicPreference: "", funFact: "", phoneNumber: "",
            pronouns: "", grade: "", location: "", email: ""
        )
    }

    private static func getUserFromLocalStorage() -> User? {
        guard let data = UserDefaults.standard.data(forKey: "storedUser"),
              let decoded = try? JSONDecoder().decode(User.self, from: data) else { return nil }
        return decoded
    }
}
