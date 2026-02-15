//
//  TripInfo.swift
//  travel
//
//  Created by Lin Jin on 1/20/25.
//

import SwiftUI

struct TripInfo: Identifiable, Decodable, Equatable, Encodable {
    var id: Int
    var driver: User?       // nil for ride requests
    var price: Int
    var departureTime: Date
    var arrivalTime: Date
    var meetingLocation: String
    var meetingLat: Double = 0
    var meetingLon: Double = 0
    var destination: String
    var destinationLat: Double = 0
    var destinationLon: Double = 0
    var genderPreference: String
    var availableSeats: Int
    var totalSeats: Int
    var guests: [User] = []
    var completed: Bool = false

    static func ==(lhs: TripInfo, rhs: TripInfo) -> Bool {
        return lhs.id == rhs.id
    }
}

 
