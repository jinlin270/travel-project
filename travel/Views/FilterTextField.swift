//
//  FilterTextField.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI
import UIKit

struct FilterTextField: View {
    
    @State private var meetingLocation: String = ""
    @State private var destination: String = ""
    @State private var date: Date = Date() // Default value for the picker
    @State private var inputText: String = ""
    @State private var numPassenger: Int = 0
    
    let genders = ["Male", "Female", "Non-binary", "Other"] // Gender options
    
    var body: some View {
        NavigationStack {

                // Text Fields
            VStack(spacing: 24) {
                TextField("From", text: $meetingLocation)
                    .textFieldStyle(CustomTextFieldStyle())
                
                TextField("To", text: $destination)
                    .textFieldStyle(CustomTextFieldStyle())
                
                DateTextField().padding(-16)
                
                TextField("# Passengers", text: $inputText, onEditingChanged: { isEditing in
                    if !isEditing {
                        // When editing ends, validate and update numPassenger
                        if let num = Int(inputText), num >= 0 {
                            numPassenger = num
                        } else {
                            numPassenger = 0
                        }
                        // Update the inputText with the formatted version
                        inputText = "\(numPassenger) Passenger\(numPassenger > 1 ? "s" : "")"
//                        print("not editing \(inputText)")
                    } else {
                        // When editing begins, show the number only (without formatting)
                        inputText = "\(numPassenger)"
//                        print("editing \(inputText)")
                    }
                    
                })
                .textFieldStyle(CustomTextFieldStyle())
                .keyboardType(.numberPad) // Ensures only numeric input
                .onChange(of: inputText) { newValue in
                    // When the input changes, only allow numeric values
                    if let number = Int(newValue), number >= 0 {
                        numPassenger = number
                        inputText = "\(numPassenger) Passenger\(numPassenger > 1 ? "s" : "")"
                    } else {
                        // If input is invalid, revert back to the numeric part only
                        inputText = String(newValue.filter { $0.isNumber })
//                        print("onChange \(inputText)")
                    }
                }
                
                }
                .padding(.top, 56)
                .padding(.horizontal, 16)
                
                
            }
            .background(Color(.systemBackground))
            .navigationBarHidden(true) //for hiding back button in uikit
            .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
           
        }

}


// Preview
struct FilterTextField_Previews: PreviewProvider {
    static var previews: some View {
        FilterTextField()
    }
}
