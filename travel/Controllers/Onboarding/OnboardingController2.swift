//
//  OnboardingController2.swift
//  travel
//
//  Created by Lin Jin on 10/6/24.
//

import Foundation
import SwiftUI

struct OnboardingController2: View {
    @State private var selectedOption: String = ""
    @State private var NextPage = false
    @State private var PrevPage = false

    let options: [RadioButtonOption] = [
        RadioButtonOption(text: "Offer Rides", imageName: "offer_rides"),
        RadioButtonOption(text: "Find Or Request Rides", imageName: "request_rides"),
        RadioButtonOption(text: "Explore the traveling community", imageName: "explore")
    ]


    var body: some View {
        ScrollView { // Allows for scrolling if content exceeds screen
            VStack {
                
    
                Image("progressBar5")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)

                Text("What would you like to do?")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.top, 56)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                // Add the Radio Button Group
                RadioButtonGroup(selectedOption: $selectedOption, options: options)
                    .padding(.horizontal, 16)
                
            }
            .padding(.vertical, 20)
            
            Spacer().frame(height: 200)
            
            NavigationButtons(   onBack: {
                PrevPage = true
            },
            onNext: {
                NextPage = true
            })
            
        }
        .background(Color(.systemBackground))
        .navigationBarHidden(true) //for hiding back button in uikit
        .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
        .navigationDestination(isPresented: $NextPage) {
            OnboardingController3()
                    }
        .navigationDestination(isPresented: $PrevPage) {
            OnboardingController1()
                    }
        }
    }


struct RadioButtonOption {
    let text: String
    let imageName: String
}

struct RadioButtonGroup: View {
    @Binding var selectedOption: String
    let options: [RadioButtonOption]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(options, id: \.text) { option in
                RadioButtonRow(option: option, isSelected: selectedOption == option.text) {
                    selectedOption = option.text
                }
            }
        }
    }
}

struct RadioButtonRow: View {
    let option: RadioButtonOption
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 16) {
                

                Image(systemName: isSelected ? "square.fill" : "square")
                                    .foregroundColor(isSelected ? .blue : .black)

                // Text
                Text(option.text)
                    .frame(maxWidth: 156, alignment: .leading)
                    .lineLimit(nil) // Allow wrapping
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Spacer()

                // Image to the right of the text
                Image(option.imageName)
                    .resizable()
                    .frame(width: 90, height: 60)
                    .cornerRadius(8)
                    .clipped()
            }
        }
        .buttonStyle(PlainButtonStyle()) // Removes default button style
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(width: 361, height: 88, alignment: .leading)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.white)   // Highlight selected
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingController2()
            .previewLayout(.sizeThatFits)
    }
}
