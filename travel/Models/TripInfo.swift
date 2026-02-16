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

    enum CodingKeys: String, CodingKey {
        case id, driver, price, departureTime, arrivalTime, meetingLocation,
             meetingLat, meetingLon, destination, destinationLat, destinationLon,
             genderPreference, availableSeats, totalSeats, guests, completed
    }

    init(id: Int, driver: User? = nil, price: Int, departureTime: Date = Date(), arrivalTime: Date = Date(),
         meetingLocation: String, meetingLat: Double = 0, meetingLon: Double = 0,
         destination: String, destinationLat: Double = 0, destinationLon: Double = 0,
         genderPreference: String, availableSeats: Int, totalSeats: Int,
         guests: [User] = [], completed: Bool = false) {
        self.id = id
        self.driver = driver
        self.price = price
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.meetingLocation = meetingLocation
        self.meetingLat = meetingLat
        self.meetingLon = meetingLon
        self.destination = destination
        self.destinationLat = destinationLat
        self.destinationLon = destinationLon
        self.genderPreference = genderPreference
        self.availableSeats = availableSeats
        self.totalSeats = totalSeats
        self.guests = guests
        self.completed = completed
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        driver = try container.decodeIfPresent(User.self, forKey: .driver)
        price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0
        departureTime = try container.decodeIfPresent(Date.self, forKey: .departureTime) ?? Date()
        arrivalTime   = try container.decodeIfPresent(Date.self, forKey: .arrivalTime)   ?? Date()
        meetingLocation = try container.decodeIfPresent(String.self, forKey: .meetingLocation) ?? ""
        meetingLat = try container.decodeIfPresent(Double.self, forKey: .meetingLat) ?? 0
        meetingLon = try container.decodeIfPresent(Double.self, forKey: .meetingLon) ?? 0
        destination = try container.decodeIfPresent(String.self, forKey: .destination) ?? ""
        destinationLat = try container.decodeIfPresent(Double.self, forKey: .destinationLat) ?? 0
        destinationLon = try container.decodeIfPresent(Double.self, forKey: .destinationLon) ?? 0
        genderPreference = try container.decodeIfPresent(String.self, forKey: .genderPreference) ?? "Any"
        availableSeats = try container.decodeIfPresent(Int.self, forKey: .availableSeats) ?? 0
        totalSeats = try container.decodeIfPresent(Int.self, forKey: .totalSeats) ?? 0
        guests = try container.decodeIfPresent([User].self, forKey: .guests) ?? []
        completed = try container.decodeIfPresent(Bool.self, forKey: .completed) ?? false
    }

    static func ==(lhs: TripInfo, rhs: TripInfo) -> Bool {
        return lhs.id == rhs.id
    }
}

 
