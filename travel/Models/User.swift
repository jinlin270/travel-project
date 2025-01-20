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
    var rideOffers: [TripInfo] = []
    var rideRequests: [TripInfo] = []
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

class UserManager: ObservableObject {
    static let shared = UserManager() // Singleton instance
    
    @Published var user: User = User(id: 1, name: "Lin Jin", rating: 5.0, numRatings:5, profilePicURL: "https://i.scdn.co/image/ab67616100005174bcb1c184c322688f10cdce7a", loudness: 5, musicPreference: "ROCK AND ROLLLL", funFact: "pokemon :)", phoneNumber: "xxx-xxx-xxxx", pronouns: "She/Her", grade: "She/Her", location: "Senior", email: "linjin@gmail.com") // Stores the user data
    
    private init() {} // Private initializer for singleton
    
    // Method to load user from API or cache
    func loadUserData(userId: Int) {
        // Check if data is already stored locally
        if let savedUser = getUserFromLocalStorage() {
            self.user = savedUser
            return
        }
        
        // If not in local storage, fetch from API
        fetchUserDataFromAPI(userId: userId)
    }
    
    // API call to fetch user data
    private func fetchUserDataFromAPI(userId: Int) {
        let url = URL(string: "https://blabla/id=\(userId)")! // Replace with your actual API
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                // Decode the user data
                do {
                    let decodedUser = try JSONDecoder().decode(User.self, from: data)
                    
                    // Save the user data to local storage
                    self?.saveUserToLocalStorage(user: decodedUser)
                    
                    // Update the published user property
                    DispatchQueue.main.async {
                        self?.user = decodedUser
                    }
                } catch {
                    print("Error decoding user data")
                }
            }
        }.resume()
    }
    
    // Save user data to UserDefaults for persistence
    private func saveUserToLocalStorage(user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "storedUser")
        }
    }
    
    // Retrieve user data from UserDefaults
    private func getUserFromLocalStorage() -> User? {
        if let savedUserData = UserDefaults.standard.data(forKey: "storedUser"),
           let decodedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
            return decodedUser
        }
        return nil
    }
}
