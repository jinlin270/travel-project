//
//  SearchRides.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

import Foundation

struct SearchRidesView: View {
    @StateObject private var viewModel = FilterViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // Dimmed background (everything outside the pop-up)
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all) // Covers the entire screen
            
            // Main content in the center
            VStack { // VStack1
                HStack {
                    Button(action: {
                        viewModel.resetTextFields()
                    }) {
                        Text("Search For Trips")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    
                    Button(action: {
                        // Exit button action here
                        isPresented = false
                    }) {
                        Image("close")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding()
                
                FilterTextField(viewModel: viewModel, passengerText: "# Passengers")
                
                HStack {
                    Button(action: {
                        viewModel.resetTextFields()
                    }) {
                        Text("Clear all")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .underline()
                    }
                    Spacer()
                    
                    Button(action: {
                        // Exit button action here
                        isPresented = false
                    }) {
                        HStack(alignment: .center, spacing: 0) {
                            // Add your button content here (e.g., Text, Image, etc.)
                            Text("Search")
                                .foregroundColor(.white)  // Text color inside the button
                                .font(.system(size: 16, weight: .bold))
                        }
                        .padding(16)
                        .frame(width: 170, height: 48, alignment: .center)
                        .background(Constants.blue)  // Background color
                        .cornerRadius(12)  // Rounded corners
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 0.75)  // Border inset to create thickness
                                .stroke(Color.black, lineWidth: 1.5)  // Border stroke color and width
                        )
                    }
                }.padding()
                
            }
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 2)
            )
            .cornerRadius(12)
            .padding()
            
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensure the content stretches properly
        }
    }
}




struct SearchRidesView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of the parent view with the @State property
        SearchRidesView(isPresented: .constant(true)) // Using .constant for the preview
    }
}
