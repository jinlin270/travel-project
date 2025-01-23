//
//  TextFieldViewModel.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var meetingLocation: String = ""
    @Published var destination: String = ""
    @Published var date: Date = Date()
    @Published var dateString: String = ""
    @Published var passengerText: String = ""
    @Published var numPassenger: Int = 0

    func resetTextFields() {
        meetingLocation = ""
        destination = ""
        dateString = ""
        date = Date()
        passengerText = ""
        numPassenger = 0
    }
}
