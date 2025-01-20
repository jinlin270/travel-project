//
//  TripInfo.swift
//  travel
//
//  Created by Lin Jin on 1/20/25.
//

import SwiftUI

struct TripInfo: Identifiable, Decodable, Equatable, Encodable {
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
    var guests: [User] = []
    var completed: Bool = false
    
    static func ==(lhs: TripInfo, rhs: TripInfo) -> Bool {
            return lhs.id == rhs.id
        }
}

 
