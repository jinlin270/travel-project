//
//  TextFieldViewModel.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

enum RecurringOption: String, CaseIterable {
    case once    = "Once"
    case daily   = "Daily"
    case weekly  = "Weekly"
    case monthly = "Monthly"
    case custom  = "Custom"
}

// MARK: - Request body sent to POST /trips
// Matches the backend TripInfo entity. driver=nil signals a ride *request* (not offer).
// guests contains the requesting user so the backend sets availableSeats/totalSeats correctly.
struct RideRequestBody: Encodable {
    struct GuestRef: Encodable { let id: Int }

    let driver: GuestRef?          // nil → ride request
    let departureTime: Date        // epoch-ms via APIClient encoder
    let arrivalTime: Date          // same as departure when unknown
    let meetingLocation: String
    let meetingLat: Double
    let meetingLon: Double
    let destination: String
    let destinationLat: Double
    let destinationLon: Double
    let genderPreference: String   // "All females" | "All males" | "Any"
    let guests: [GuestRef]         // requesting user(s)
    let availableSeats: Int
    let totalSeats: Int
    let completed: Bool
}

class FilterViewModel: ObservableObject {
    @Published var meetingLocation: String = ""
    @Published var destination: String = ""
    @Published var date: Date = Date()
    @Published var dateString: String = ""
    @Published var passengerText: String = ""
    @Published var numPassenger: Int = 0
    @Published var recurringOption: RecurringOption = .once
    @Published var genderPreference: String = "Any"

    // UI state
    @Published var isPosting: Bool = false
    @Published var postError: String? = nil
    @Published var postSuccess: Bool = false

    func resetTextFields() {
        meetingLocation = ""
        destination = ""
        dateString = ""
        date = Date()
        passengerText = ""
        numPassenger = 0
        recurringOption = .once
        genderPreference = "Any"
        postError = nil
        postSuccess = false
    }

    // MARK: - API

    @MainActor
    func postRideRequest() async {
        isPosting = true
        postError = nil

        let userId = UserManager.shared.user.id
        let body = RideRequestBody(
            driver: nil,                                     // nil = ride request (no driver yet)
            departureTime: date,
            arrivalTime: date,                               // form doesn't collect arrival; use departure
            meetingLocation: meetingLocation,
            meetingLat: 0, meetingLon: 0,                   // coordinates not collected in form
            destination: destination,
            destinationLat: 0, destinationLon: 0,
            genderPreference: genderPreference,
            guests: [RideRequestBody.GuestRef(id: userId)], // requester is the first guest
            availableSeats: max(numPassenger, 1),
            totalSeats: max(numPassenger + 1, 4),
            completed: false
        )
        do {
            try await APIClient.shared.requestVoid("/trips", method: "POST", body: body)
            postSuccess = true
        } catch {
            postError = error.localizedDescription
        }
        isPosting = false
    }
}
