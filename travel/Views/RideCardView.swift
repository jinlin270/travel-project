//
//  RideCardView.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//

import SwiftUI
struct RideCardView: View {
    var ride_card: RideCard
    @StateObject private var imageFetcher = ImageFetcher()
    
    var body: some View {
        ZStack {
            // Card Boundary
            Rectangle()
                .foregroundColor(.clear)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.75)
                        .stroke(Color.black, lineWidth: 1.5)
                )
            
            VStack(){
                // VStack1 (Top VStack)
                
                HStack {
                    //HStack1 (profile)
                    if let image = imageFetcher.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    } else {
                        Image("profile_icon")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .clipShape(Circle()) // Make the image circular
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                            .onAppear {
                                imageFetcher.fetchImage(from: ride_card.driver.profilePicURL)
                            }
                    }
                    
                    Spacer().frame(width:13)
                    VStack{
                        //VStack2 (name and review)
                        HStack{
                            Text(ride_card.driver.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Image("Bookmark")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)
                        
                        Spacer().frame(height:4)
                        
                        HStack(spacing:4){
                            Image("star")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text(String(ride_card.driver.rating))
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            Image("dot")
                                .resizable()
                                .frame(width: 3, height: 3)
                            
                            Text("\(ride_card.driver.numRatings) reviews")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            
                            Text("$\(ride_card.price)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .trailing) // Align to the trailing edge
                                .padding(.trailing, 16)
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }//end of VStack1 (name and review)
                    
                } //end of HStack1 (profile)
                .padding(.leading, 16)
                
                Spacer().frame(height:8)
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal, 16)
                
                Spacer().frame(height:8)
                
                HStack{//HStack2 (rest of card)
                    VStack{ //VStack3 (time and location)
                        HStack{//HStack 2.1 (time)
                            Text("\(DateFormatter.timeFormatter.string(from: ride_card.departureTime))")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image("Forward")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Spacer()
                            
                            Text("\(DateFormatter.timeFormatter.string(from: ride_card.arrivalTime))")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.trailing)
                            
                        }.frame(maxWidth: 214, alignment: .leading)
                            .padding(.leading, 16)
                        //end of HStack2.1 (time)
                        
                        HStack{//HStack 2.1 (time)
                            Text("\(ride_card.meetingLocation)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                                .underline()
                            
                            
                            Text("\(ride_card.destination)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: 214, alignment: .trailing)
                                .underline()
                            
                        }.frame(maxWidth: 214, alignment: .leading)
                            .padding(.leading, 16)
                        
                    }.frame(maxHeight: 64)
                    //end of VStack3 (time and location)
                    
                    Spacer()
                    Divider()
                        .frame(height: 60)
                        .background(Color.gray)
                    Spacer()
                    
                    VStack{//VStack4 (preference and availability)
                        Text("\(ride_card.gender_preference)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                            .frame(height: 40 / 3)
                        
                        Text("Availability")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .frame(height: 40 / 3)
                        
                        HStack{
                            Text("\(ride_card.availableSeats) / \(ride_card.totalSeats)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                            Image("Chair")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .frame(height: 40 / 3)
                        
                    }
                    .padding(.trailing, 16)
                    .frame(maxHeight: 64, alignment: .trailing)
                    //end of VStack4
                    
                }//end of HStack2 (second part of card)
                
                Spacer().frame(height:20)
                
                HStack { // Reserve Button
                    Spacer() // This will push the button to the right
                    HStack(alignment: .center, spacing: 0) {
                        Text("Reserve")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center) // Center the text
                    }
                    .frame(maxWidth: 165, minHeight: 32, maxHeight: 32, alignment: .center)
                    .background(Color(red: 0.07, green: 0.27, blue: 0.41)) // Apply background color
                    .cornerRadius(8) // Rounded corners
                    .padding(.trailing, 16) // Add 16 padding to the right
                }
                .frame(maxWidth: .infinity)

                
            } //end of VStack1 (Overall Sections)
            .padding(.top, 16)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 12)
        }//end of ZStack (boundary)
    }
}
    

let user: User = User(id: 1, name: "Lin Jin", rating: 5.0, numRatings:5, profilePicURL: "https://i.scdn.co/image/ab67616100005174bcb1c184c322688f10cdce7a", loudness: 5, musicPreference: "ROCK AND ROLLLL", funFact: "pokemon :)", phoneNumber: "xxx-xxx-xxxx", pronouns: "She/Her", grade: "She/Her", location: "Senior", email: "linjin@gmail.com")
let ride_card1: RideCard = RideCard(id:1, driver: user,  bookmarked: false, price: 15, departureTime: Date(), arrivalTime: Date(), meetingLocation: "161 Ho Plaza, Ithaca, NY", destination: "So Ho, New York, NY", gender_preference: "All females", availableSeats: 2, totalSeats: 4)

struct RideCard_Previews: PreviewProvider {
    static var previews: some View {
        RideCardView(ride_card: ride_card1)
    }
}
