//
//  OnboardingProfile.swift
//  travel
//
//  Created by Lin Jin on 1/17/25.
//

import SwiftUI

struct OnboardingProfile: View {
    @State private var NextPage = false
    @State private var PrevPage = false

    var body: some View {
        NavigationStack { // Use NavigationStack for iOS 16 and later
            VStack {
                Image("progressBar6")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                
                Spacer().frame(height: 50)
                
                Text("Upload your Profile Picture")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Spacer().frame(height: 16)
                UploadPictureView(UploadPic:{}) // TODO: Add your upload picture logic
                Spacer()
                
                NavigationButtons(
                    onBack: {
                        PrevPage = true
                    },
                    onNext: {
                        NextPage = true
                    })
                
            }
            .background(Color(.systemBackground))
            .navigationDestination(isPresented: $NextPage) {
                ExploreRides() // Destination view for NextPage
            }
            .navigationDestination(isPresented: $PrevPage) {
                OnboardingController2() // Destination view for PrevPage
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the back button if needed
        .navigationBarHidden(false) // Ensure the navigation bar is visible for navigation actions
    }
}

struct OnboardingProfile_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingProfile()
    }
}
