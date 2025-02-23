//
//  RideReserved.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//
import SwiftUI

struct RideReserved: View {
    var reserveOrOffer: String
    @State private var NavHome = false
    @State private var NavCommunity = false
    @State private var NavProfile = false
    
    var body: some View {
        NavigationStack { // Wrap everything inside a NavigationStack
            ZStack {
                // Background Layer
                GeometryReader { geometry in
                    VStack {
                        Image("rideReserved")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height - 5,
                                alignment: .top
                            )
                            .clipped() // Ensure it doesn't overflow
                            .ignoresSafeArea(edges: .top) // Extend into the safe area at the top
                        Spacer() // Ensures the image ends before BottomNavigationBar
                    }
                }
                .zIndex(0) // Set this to be the lowest layer

                // Foreground Layer
                VStack {
                    Spacer().frame(height: 460)
                    
                    Text("Congratulations!")
                        .foregroundColor(.black)  // Text color inside the button
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 16)
                        .background(.clear)  // Make sure background is clear
                    
                    Text("You successfully \(reserveOrOffer) the ride!")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .bold))
                        .padding(.bottom, 16)
                        .background(.clear)  // Make sure background is clear

                    HStack {
                        Text("See your ride information in ")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .background(.clear)  // Make sure background is clear
                        
                        Button(action: {
                            NavProfile = true
                        }) {
                            Text("Profile")
                                .foregroundColor(Constants.blue)
                                .font(.system(size: 16, weight: .bold))
                                .underline()
                                .padding(.leading, -5)
                        }
                        .background(.clear)  // Make sure background is clear
                    }
                    .background(.clear)  // Ensure HStack also has clear background

                    BottomNavigationBar(
                        NavHome: $NavHome,
                        NavCommunity: $NavCommunity,
                        NavProfile: $NavProfile
                    )
                    .zIndex(1) // Ensure this layer is above the background
                }
                .background(.clear)  // Ensure VStack also has clear background
                .zIndex(1) // Make sure foreground content is above the background image

            }
            .navigationDestination(isPresented: $NavHome) {
                ExploreRides() // Destination for Home
            }
            .navigationDestination(isPresented: $NavCommunity) {
                GroupView() // Destination for Community
            }
            .navigationDestination(isPresented: $NavProfile) {
                ProfilePageView() // Destination for Profile
            }
        }
    }
}

struct RideReserved_Previews: PreviewProvider {
    static var previews: some View {
        RideReserved(reserveOrOffer: "reserved")
    }
}
