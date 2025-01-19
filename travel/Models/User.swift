//
//  User.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.
//

import SwiftUI

struct User: Identifiable, Decodable, Equatable {
    var id: Int
    var name: String
    var rating: Double
    var numRatings: Int
    var profilePicURL: String
    var loudness: Int //1-5
    var musicPreference: String
    var funFact: String
    var phoneNumber: String
    var pronouns: String
    var grade: String
    var location: String
    var email: String
    
    
    static func ==(lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id
        }
        
}
