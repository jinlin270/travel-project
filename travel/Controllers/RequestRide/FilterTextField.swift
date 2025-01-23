//
//  FilterTextField.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI
import UIKit

struct FilterTextField: View {
    @ObservedObject var viewModel: FilterViewModel
    var passengerText: String

    var body: some View {
       
            // Text Fields
            VStack() { // Adjust spacing to remove extra vertical gaps
                TextField("From", text: $viewModel.meetingLocation)
                    .textFieldStyle(CustomTextFieldStyle())
                
                TextField("To", text: $viewModel.destination)
                    .textFieldStyle(CustomTextFieldStyle())
                
                DateTextField(viewModel: viewModel) // Removed negative padding
                
                TextField("\(passengerText)", text: $viewModel.passengerText)
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(.numberPad)
                .onChange(of: viewModel.passengerText) { newValue in
                    // When the input changes, only allow numeric values
                    if let number = Int(newValue), number >= 0 {
                        viewModel.numPassenger = number
                        viewModel.passengerText = "\(viewModel.numPassenger) Passenger\(viewModel.numPassenger > 1 ? "s" : "")"
                    } else {
                        // If input is invalid, revert back to the numeric part only
                        viewModel.passengerText = String(newValue.filter { $0.isNumber })
                    }
                }
            }
            .padding(.horizontal, 16)
    
    }
}

// Preview
struct FilterTextField_Previews: PreviewProvider {
    static var previews: some View {
        FilterTextField(viewModel: FilterViewModel(), passengerText: "# Passengers")
    }
}
