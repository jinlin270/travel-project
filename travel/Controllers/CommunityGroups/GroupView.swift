//
//  GroupView.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//


import SwiftUI
import Foundation

struct GroupView: View {
    @State private var NavHome = false
    @State private var NavCommunity = false
    @State private var NavProfile = false
    
    @State var isRideOffer = true
    @State private var isRideInfo = false
    @State private var MyGroup = true
    @State private var notMyGroup = false
    @State private var selectedOption: String = "Filter"
    @State private var isMenuOpen: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Community")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 8)
                .padding(.horizontal, 24)

            Spacer().frame(height: 8)

            CommunityBar()

            // Main content
            ZStack {
                VStack(spacing: 0) {
                    // Dropdown and Search Bar
                    HStack(spacing: 8) {
                        DropdownMenu(selectedOption: $selectedOption, isMenuOpen: $isMenuOpen)
                        SearchBar()
                    }
                    .padding(.horizontal, 24)
                    .zIndex(1)

                    // Filter and See all
                    HStack {
                        Text("\(selectedOption)")
                            .font(.system(size: 12))
                            .foregroundColor(.black)

                        Spacer()

                        Text("See all")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 8)

                    // Community Groups ScrollView
                    ScrollCardsView(isRideOffer: $isRideOffer, isRideInfo: $isRideInfo, isMyGroup: $notMyGroup)
                        .frame(minHeight: 100)
                        .padding(.top, 8)

                    // Your Group Header
                    Text("Your Group")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        .padding(.bottom, 8)

                    // Your Groups ScrollView
                    ScrollCardsView(isRideOffer: $isRideOffer, isRideInfo: $isRideInfo, isMyGroup: $MyGroup)
                        .frame(minHeight: 100)
                        .padding(.top, 8)
                }
            }

            // Bottom Navigation Bar
            BottomNavigationBar(
                NavHome: $NavHome,
                NavCommunity: $NavCommunity,
                NavProfile: $NavProfile
            )
        }
        .frame(maxWidth: .infinity)
            .navigationDestination(isPresented: $NavHome) {
                ExploreRides()  // Destination for Home
            }
            .navigationDestination(isPresented: $NavProfile) {
                ProfilePageView()  // Destination for Profile
            }
           

            
    }
}


struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
