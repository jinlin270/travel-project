//
//  RideCard.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//
import SwiftUI

struct RideCard: Identifiable, Decodable, Equatable {
    var id: Int
    var driver: User
    var bookmarked: Bool
    var price: Int
    var departureTime: Date // May be Date object instead?
    var arrivalTime: Date
    var meetingLocation: String
    var destination: String
    var gender_preference: String
    var availableSeats: Int
    var totalSeats: Int
    
    static func ==(lhs: RideCard, rhs: RideCard) -> Bool {
            return lhs.id == rhs.id
        }
}

