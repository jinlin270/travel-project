//
//  tempData.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//

import SwiftUI
//TODO: update views to use current user and not static data
let user1 = User(
    id: 2,
    name: "Lin Jin",
    rating: 5.0,
    numRatings: 5,
    profilePicURL: "https://i.scdn.co/image/ab67616100005174bcb1c184c322688f10cdce7a",
    loudness: 5,
    musicPreference: "ROCK AND ROLLLL",
    funFact: "pokemon :)",
    phoneNumber: "xxx-xxx-xxxx",
    pronouns: "She/Her",
    grade: "Senior",
    location: "Cornell University",
//    institution: "Cornell University",
//    institution: "Cornell University",
    email: "linjin@gmail.com"
)

let trip1 = TripInfo(
    id: 1,
    driver: user1,
    bookmarked: false,
    price: 15,
    departureTime: Date(),
    arrivalTime: Date(),
    meetingLocation: "161 Ho Plaza, Ithaca, NY",
    destination: "So Ho, New York, NY",
//    stops: ["161 Ho Plaza, Ithaca, NY", "So Ho, New York, NY"],
//    stops: ["161 Ho Plaza, Ithaca, NY", "So Ho, New York, NY"],
//    stops: ["161 Ho Plaza, Ithaca, NY", "So Ho, New York, NY"],
    gender_preference: "All females",
    availableSeats: 2,
    totalSeats: 4
)

let rideCardsData = [TripInfo(
    id: 1,
    driver: user1,
    bookmarked: false,
    price: 15,
    departureTime: Date(),
    arrivalTime: Date(),
    meetingLocation: "161 Ho Plaza, Ithaca, NY",
    destination: "So Ho, New York, NY",
//    stops: ["161 Ho Plaza, Ithaca, NY", "So Ho, New York, NY"],
    gender_preference: "All females",
    availableSeats: 2,
    totalSeats: 4
),
    TripInfo(
                    id: 2,
                    driver: user1,
                    bookmarked: false,
                    price: 15,
                    departureTime: Date(),
                    arrivalTime: Date(),
                    meetingLocation: "161 Ho Plaza, Ithaca, NY",
                    destination: "So Ho, New York, NY",
//                    stops: ["161 Ho Plaza, Ithaca, NY", "So Ho, New York, NY"],
//                    stops: ["161 Ho Plaza, Ithaca, NY", "So Ho, New York, NY"],
                    gender_preference: "All females",
                    availableSeats: 2,
                    totalSeats: 4
                ),
     TripInfo(
                     id: 3,
                     driver: user1,
                     bookmarked: false,
                     price: 15,
                     departureTime: Date(),
                     arrivalTime: Date(),
                     meetingLocation: "161 Ho Plaza, Ithaca, NY",
                     destination: "So Ho, New York, NY",
//                     stops: ["161 Ho Plaza, Ithaca, NY", "So Ho, New York, NY"],
//                     stops: ["161 Ho Plaza, Ithaca, NY", "So Ho, New York, NY"],
                     gender_preference: "All females",
                     availableSeats: 2,
                     totalSeats: 4
                 )]
let communityGroupsData = [GroupModel(id: 1, groupName: "Cornell 2025", profilePicture: "https://cdn.britannica.com/08/235008-050-C82C6C44/Cornell-University-Uris-Library-Ithaca-New-York.jpg", isPublic: true, numMembers: 15, filterTags: Set(arrayLiteral: "Popular"), latitude: Double(42.4534), longitude: Double(76.4735))]

