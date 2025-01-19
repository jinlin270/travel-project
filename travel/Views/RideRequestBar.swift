//
//  RideRequestBar.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.
//

import SwiftUI

struct RideRequestBar: View {
    @State private var InCity = false
    @State private var OutCity = false
    @State private var InState = false
    @State private var OutState = false
    var body: some View {
        VStack{
            HStack(alignment: .top) {
                // Space Between
                
                VStack{
                    Image("Point On Map")
                        .resizable()
                        .scaledToFit()
                        .frame(width:18, height:18)
                        .padding(.leading, 12)
                        .padding(.trailing, 12)
                        .padding(.top, 4)
                        .padding(.bottom, 8)
                    Text("In-City")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .frame(alignment: .center)
                        .padding(.bottom, 4)
                }
                .frame(width: 80)
                .background(InCity ? Color.yellow.opacity(0.2) : Color.clear) // Highlight when true
                .cornerRadius(8)
                .onTapGesture {
                    InCity = true
                    OutCity = false
                    InState = false
                    OutState = false
                    
                }
                
                
                Spacer() // Adds space between views
                
                // Alternative Views and Spacers
                VStack{
                    Image("Routing")
                        .resizable()
                        .scaledToFit()
                        .frame(width:18, height:18)
                        .padding(.leading, 12)
                        .padding(.trailing, 12)
                        .padding(.top, 4)
                        .padding(.bottom, 8)
                    Text("Out-of-City")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .frame(alignment: .center)
                        .padding(.bottom, 4)
                }
                .frame(width: 80)
                .background(OutCity ? Color.yellow.opacity(0.2) : Color.clear) // Highlight when true
                .cornerRadius(8)
                .onTapGesture {
                    InCity = false
                    OutCity = true
                    InState = false
                    OutState = false
                }
                
                Spacer() // You can add more spacers if necessary
                VStack{
                    Image("Streets Map Point")
                        .resizable()
                        .scaledToFit()
                        .frame(width:18, height:18)
                        .padding(.leading, 12)
                        .padding(.trailing, 12)
                        .padding(.top, 4)
                        .padding(.bottom, 8)
                    Text("In-State")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .frame(alignment: .center)
                        .padding(.bottom, 4)
                }
                .frame(width: 80)
                .background(InState ? Color.yellow.opacity(0.2) : Color.clear) // Highlight when true
                .cornerRadius(8)
                .onTapGesture {
                    InCity = false
                    OutCity = false
                    InState = true
                    OutState = false
                }
                Spacer()
                VStack{
                    Image("Signpost")
                        .resizable()
                        .scaledToFit()
                        .frame(width:18, height:18)
                        .padding(.leading, 12)
                        .padding(.trailing, 12)
                        .padding(.top, 4)
                        .padding(.bottom, 8)
                    Text("Out-of-State")
                        .frame(width: 80)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .frame(alignment: .center)
                        .padding(.bottom, 4)
                }
                .frame(width: 80)
                .background(OutState ? Color.yellow.opacity(0.2) : Color.clear) // Highlight when true
                .cornerRadius(8)
                .onTapGesture {
                    InCity = false
                    OutCity = false
                    InState = false
                    OutState = true
                }
            }
            .padding(0)
            .frame(width: 361, alignment: .top)
            
            ZStack{
                if InCity {
                    HStack {
                        Divider()
                            .frame(width: 74, height: 5)
                            .background(Color.gray)
                            .padding(.top, -8)
                    }
                    .padding(.leading, -178) // Offset to align with In-City
                } else if OutCity {
                    HStack {
                        Divider()
                            .frame(width: 74, height: 5)
                            .background(Color.gray)
                            .padding(.top, -8)
                    }
                    .padding(.leading, -85) // Offset to align with Out-of-City
                } else if InState {
                    HStack {
                        Divider()
                            .frame(width: 74, height: 5)
                            .background(Color.gray)
                            .padding(.top, -8)
                    }
                    .padding(.leading, 95) // Offset to align with In-State
                } else if OutState {
                    HStack {
                        Divider()
                            .frame(width: 74, height: 5)
                            .background(Color.gray)
                            .padding(.top, -8)
                    }
                    .padding(.leading, 280) // Offset to align with Out-of-State
                }
                
                
//                Divider()
//                    .background(Color.gray)
                Divider()
                    .frame(height: 3)
                    .background(Color.clear)
            }
        }
    }
}

struct RideRequestBar_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestBar()
    }
}

