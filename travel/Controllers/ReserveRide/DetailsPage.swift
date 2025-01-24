//
//  DetailsPage.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

struct DetailsPage: View {
    var tripInfo: TripInfo
    @State private var NavExplore = false
    @State private var NavCheckout = false
    @StateObject private var imageFetcher = ImageFetcher()

    var body: some View {
        VStack {//VStack1
            HStack{
                Button(action: {
                    NavExplore = true
                }) {
                    Image("SimpleArrowLeft")
                        .resizable()
                        .scaledToFit()
                        .frame(width:24, height:24)
                        .padding(.leading, 16)
                }
                
                Spacer()
                Text("Route Detail")
                    .foregroundColor(.black)  // Text color inside the button
                    .font(.system(size: 18, weight: .bold))
                    .padding(.trailing, 16)
                
            }.padding(.horizontal, 16)
            
            Divider()
                .frame(height: 1)
                .background(Color.black.opacity(0.5))
            
            //TODO: Map View
            
            DriverInfoView(driver: tripInfo.driver)
            //TODO: Profile min
            
            //TODO: Stop Display
            StopsView(
                stops: ["Stop 1", "Stop 2", "Stop 3", "Stop 4"],
                arrivalTimes: [
                    Date(),
                    Date().addingTimeInterval(3600),
                    Date().addingTimeInterval(7200),
                    Date().addingTimeInterval(10800)
                ]
            ).frame(width:261)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            //TODO: Guest Display
            
            Divider()
                .frame(height: 1)
                .background(Color.black.opacity(0.5))
            
            HStack{
                Text("Total")
                    .foregroundColor(.black)  // Text color inside the button
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Text("$")
                    .foregroundColor(.black)  // Text color inside the button
                    .font(.system(size: 18, weight: .bold))
            }.padding(16)
            
            
            Button(action: {
                NavCheckout = true
            }) {
                Text("Check Out")
                    .foregroundColor(.black) // White text color
                    .font(.system(size: 16, weight: .bold)) // Bold font
                    .padding() // Add padding inside the button
                    .frame(maxWidth: .infinity) // Optional: Make the button fill available width
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Constants.highlighterYellow) // Blue background
                    )
            }.padding(.horizontal, 32)
                .padding(.bottom, 16)
            
        }
        .navigationDestination(isPresented: $NavExplore) {
            ExploreRides()}
        .navigationDestination(isPresented: $NavCheckout) {
            CheckoutView(tripInfo: tripInfo)
                .navigationBarHidden(true) //for hiding back button in uikit
                .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
        } //VStack1
    }//View
}

struct DetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailsPage(tripInfo: trip1)
            .previewDevice("iPhone 14") // You can adjust this to your preferred device
            .previewLayout(.sizeThatFits) // Makes the preview fit content size
    }
}
