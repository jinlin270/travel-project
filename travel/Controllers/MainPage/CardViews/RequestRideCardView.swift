//
//  RequestRideCardView.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.
//

import SwiftUI
struct RequestRideCardView: View {
    var ride_card: TripInfo
    
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
               
                HStack{//HStack 2.1 (time)
                    Text("\(ride_card.meetingLocation)")
                        .font(.system(size: 14, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                        .underline()
                        .frame(maxWidth: .infinity)
                        .frame(minWidth:140)
                    
                    Spacer()
                    
                    Image("Forward")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    
                    Text("\(ride_card.destination)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .underline()
                        .frame(minWidth:140)
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                
                Spacer().frame(height:8)
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal, 16)
                
//                Spacer().frame(height:8)
                
                
                VStack{ //VStack3
                    HStack{//HStack 2.1 (time)
                        Text("\(DateFormatter.shortDateFormatter.string(from: ride_card.departureTime))")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        
                        Text("\(ride_card.genderPreference)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                  
                    Spacer().frame(height: 8)
                    
                    HStack{
                        Text("Expire On: \(DateFormatter.shortDateFormatter.string(from: ride_card.arrivalTime))")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.trailing)
                        
                        Spacer()
                        
                        Text("Guests: \(ride_card.guests.count)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.black)
                        profilePicsView(for: ride_card.guests)
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    
                }.frame(maxHeight: 64)
                
                //end of VStack3
                
                
                Spacer().frame(height:20)
                
                HStack { // Reserve Button
                    Spacer() // This will push the button to the right
                    HStack(alignment: .center, spacing: 0) {
                        Text("Offer Ride")
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
    

struct RequestRideCardView_Previews: PreviewProvider {
    static var previews: some View {
        RequestRideCardView(ride_card: ride_card1)
    }
}
