//
//  RequestRideCard.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.
//
import SwiftUI

struct RequestRideCard: Identifiable, Decodable, Equatable {
    var id: Int
    var guests: [User]
    var price: Int
    var departureDate: Date
    var expireDate: Date
    var meetingLocation: String
    var destination: String
    var gender_preference: String

    
    static func ==(lhs: RequestRideCard, rhs: RequestRideCard) -> Bool {
            return lhs.id == rhs.id
        }
}
