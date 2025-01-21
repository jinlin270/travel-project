//
//  NavigationBar.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//
import SwiftUI

struct BottomNavigationBar: View {
    @Binding var NavHome : Bool
    @Binding var NavCommunity : Bool
    @Binding var NavProfile : Bool

    var body: some View {
        NavigationStack {
            VStack {
                Spacer() // Push the navigation bar to the bottom of the screen
                
                HStack(alignment: .top, spacing: 8) {
                    // Add your navigation bar items here
                    Button(action: {
                        NavHome = true
                    }) {
                        VStack {
                            Image("explore_icon")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            
                            Text("Home")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }.frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {
                        NavCommunity = true
                    }) {
                        VStack {
                            Image("Global")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text("Search")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }.frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {
                        NavProfile = true
                    }) {
                        VStack {
                            Image("profile_icon")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            
                            Text("Profile")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }.frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 80)
                .padding(.horizontal, 8)
                .padding(.vertical, 0)
                .padding(.top, 12)
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                .background(Constants.blue)
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }.background(Color(.systemBackground))
            .navigationBarHidden(true) //for hiding back button in uikit
            .navigationBarBackButtonHidden(true) //for hiding back button in swiftui

    }
}

struct Constants {
    static let blue: Color = Color(red: 0.07, green: 0.27, blue: 0.41)
    static let main4: Color = Color(red: 0, green: 0.12, blue: 0.19)
}

