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

    init(id: Int, name: String, rating: Double, numRatings: Int, profilePicURL: String,
         loudness: Int, musicPreference: String, funFact: String, phoneNumber: String,
         pronouns: String, grade: String, location: String, email: String) {
        self.id = id; self.name = name; self.rating = rating; self.numRatings = numRatings
        self.profilePicURL = profilePicURL; self.loudness = loudness
        self.musicPreference = musicPreference; self.funFact = funFact
        self.phoneNumber = phoneNumber; self.pronouns = pronouns
        self.grade = grade; self.location = location; self.email = email
    }

    // Exclude rideOffers/rideRequests from JSON encoding/decoding —
    // the backend User entity does not contain these fields.
    enum CodingKeys: String, CodingKey {
        case id, name, rating, numRatings, profilePicURL, loudness,
             musicPreference, funFact, phoneNumber, pronouns, grade,
             location, email
    }

    // Backend stores optional profile fields as SQL NULL → JSON null.
    // Use decodeIfPresent with "" fallback so the decoder never throws on null strings.
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id           = try c.decode(Int.self, forKey: .id)
        name         = try c.decodeIfPresent(String.self, forKey: .name)         ?? ""
        rating       = try c.decodeIfPresent(Double.self, forKey: .rating)       ?? 0
        numRatings   = try c.decodeIfPresent(Int.self,    forKey: .numRatings)   ?? 0
        profilePicURL = try c.decodeIfPresent(String.self, forKey: .profilePicURL) ?? ""
        loudness     = try c.decodeIfPresent(Int.self,    forKey: .loudness)     ?? 3
        musicPreference = try c.decodeIfPresent(String.self, forKey: .musicPreference) ?? ""
        funFact      = try c.decodeIfPresent(String.self, forKey: .funFact)      ?? ""
        phoneNumber  = try c.decodeIfPresent(String.self, forKey: .phoneNumber)  ?? ""
        pronouns     = try c.decodeIfPresent(String.self, forKey: .pronouns)     ?? ""
        grade        = try c.decodeIfPresent(String.self, forKey: .grade)        ?? ""
        location     = try c.decodeIfPresent(String.self, forKey: .location)     ?? ""
        email        = try c.decodeIfPresent(String.self, forKey: .email)        ?? ""
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
