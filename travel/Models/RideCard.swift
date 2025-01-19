//
//  RideCard.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//
import SwiftUI

struct RideCard: Identifiable, Decodable, Equatable {
    var id: Int
    var name: String
    var rating: Double
    var numRatings: Int
    var bookmarked: Bool
    var price: Int
    var departureTime: String // May be Date object instead?
    var arrivalTime: String
    var meetingLocation: String
    var destination: String
    var gender_preference: String
    var availableSeats: Int
    var totalSeats: Int
    var profilePicURL: String
    
    static func ==(lhs: RideCard, rhs: RideCard) -> Bool {
            return lhs.id == rhs.id
        }
}
