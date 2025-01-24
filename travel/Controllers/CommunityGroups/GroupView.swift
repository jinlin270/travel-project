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
        
        VStack {
            // Your main content here, for example:
        
                Text("Community")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .frame(alignment: .center)
                
                Spacer()
                
            CommunityBar()
            
            ZStack{
                VStack{
                    HStack{
                        DropdownMenu(selectedOption: $selectedOption, isMenuOpen: $isMenuOpen).padding(.leading, 16)
                        SearchBar()
                    }.padding(.horizontal, 16)
                    .zIndex(1)
                        
                    
                    HStack{
                        Text("\(selectedOption)")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.leading , 16)
                        
                        Spacer()
                        
                        Text("See all")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.trailing , 16)
                    }.padding(.bottom, -30)
                        .padding(.top, 16)
                    
                    ScrollCardsView(isRideOffer: $isRideOffer, isRideInfo: $isRideInfo, isMyGroup: $notMyGroup)
                        .frame(minHeight: 100)
                    

                    Text("Your Group")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading , 16)
                        .padding(.bottom, -30)
                        .padding(.top, 16)
        
                    
                    ScrollCardsView(isRideOffer: $isRideOffer, isRideInfo: $isRideInfo, isMyGroup: $MyGroup)
                        .frame(minHeight: 100)
                }
                
            }
          

            // Add the BottomNavigationBar
                BottomNavigationBar(
                    NavHome: $NavHome,
                    NavCommunity: $NavCommunity,
                    NavProfile: $NavProfile
                )
            }
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
