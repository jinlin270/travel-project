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
                FancyRadioButton(selectedOption: $selectedOption, options: options)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingController2()
            .previewLayout(.sizeThatFits)
    }
}
