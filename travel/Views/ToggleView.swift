//
//  SlidingBar.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.

import SwiftUI

struct ToggleView: View {
    @Binding var isRideOffer: Bool
    let blueColor = Color(UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0))
    
    var body: some View {
        VStack {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray, lineWidth: 2) // Adding a border
                    .frame(width: 268, height: 40)
                    .background(Color.clear)
                
                // Slider (moving part)
                RoundedRectangle(cornerRadius: 25)
                    .fill(isRideOffer ? blueColor : blueColor)
                    .frame(width: 132, height: 36)
                    .offset(x: isRideOffer ? -66 : 66) // Moves the slider
                    .animation(.easeInOut, value: isRideOffer)
                
                // Texts
                HStack {
                    HStack {
                        Image(isRideOffer ? "HandStars2" : "HandStars")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        Text("Ride Offer")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(isRideOffer ? .white : .black)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                            .frame(width:62)
                    }
                    .padding(.leading, 9)
                    .onTapGesture {
                            isRideOffer = true
                        }
                    
                    Spacer().frame(width:40)
                    
                    HStack {
                        Image(isRideOffer ? "Routing" : "Routing2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
//                            .padding(.trailing, 8)
                        
                        Text("Ride Requests")
                            .frame(width:87)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(isRideOffer ? .black : .white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                    }
                }
                .padding(.horizontal, 5)
                .onTapGesture {
                    isRideOffer = false
                }
            }
            .frame(width: 200)
            .padding()
        }
        .padding()
    }
}

