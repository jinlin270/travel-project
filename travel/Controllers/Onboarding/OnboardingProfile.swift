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
        NavigationView {
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
                UploadPictureView(UploadPic:{}) // TODO
                Spacer()
                
                NavigationButtons(   onBack: {
                    PrevPage = true
                },
                onNext: {
                    NextPage = true
                })
                
            }.background(Color(.systemBackground))
                .navigationBarHidden(true) //for hiding back button in uikit
                .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
                .navigationDestination(isPresented: $NextPage) {
                    ExploreRides()
                            }
                .navigationDestination(isPresented: $PrevPage) {
                    OnboardingController2()
                            }
        }
    }
}

struct OnboardingProfile_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingProfile()
    }
}
