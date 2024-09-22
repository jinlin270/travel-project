//
//  Explore.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
import SwiftUI

struct ExploreRides: View {
    @State private var NavHome = false
    @State private var NavCommunity = false
    @State private var NavProfile = false

    var body: some View {
        VStack {
            // Your main content here, for example:
            Text("Main Content Goes Here")
                .font(.largeTitle)
                .padding()

            // Add the BottomNavigationBar
            BottomNavigationBar(
                NavHome: $NavHome,
                NavCommunity: $NavCommunity,
                NavProfile: $NavProfile
            )
        }
        .navigationDestination(isPresented: $NavHome) {
            OnboardingProfile()  // Destination for Home
        }
        .navigationDestination(isPresented: $NavCommunity) {
            OnboardingController2()  // Destination for Community
        }
        .navigationDestination(isPresented: $NavProfile) {
            OnboardingController2()  // Destination for Profile
        }
    }
}

struct ExploreRides_Previews: PreviewProvider {
    static var previews: some View {
        ExploreRides()
    }
}
