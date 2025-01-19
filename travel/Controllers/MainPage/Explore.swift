//
//  Explore.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
import SwiftUI
import Foundation

struct ExploreRides: View {
    @State private var NavHome = false
    @State private var NavCommunity = false
    @State private var NavProfile = false
    @State private var RequestRide = false
    @State private var OfferRide = false
    @State private var isRideOffer = true
    @State private var showCalendar = false
    @State var selectedDate = Date()
    @State private var rideCount: Int = 0
    
    var currentDate: Date {
        Date()
    }
    
    var day: Int {
        Calendar.current.component(.day, from: currentDate)
    }
    
    var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM" // Full month name (e.g., July)
        return formatter.string(from: currentDate)
    }
    
    var year: String {
        let yearValue = Calendar.current.component(.year, from: currentDate)
        return String(yearValue)
    }
                            

    var body: some View {
        VStack {
            // Your main content here, for example:
            HStack{
                Text("Explore")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .frame(alignment: .leading)
                    .padding(.leading, 16)
                Spacer()
                Text("\(monthName) \(year)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                    .frame(alignment: .trailing)
//                    .padding(.leading, 16)
                Image("Calendar")
                    .resizable()
                    .scaledToFit()
                    .frame(width:16, height:16)
                    .padding(.trailing, 16)
                    .onTapGesture {
                        showCalendar.toggle()
                    }
            }
            
            ToggleView(isRideOffer: $isRideOffer).padding(.top, -30).padding(.bottom, -15)
//            if showCalendar {
//                Color.black.opacity(0.3)
//                    .edgesIgnoringSafeArea(.all) // Makes the dimming cover the entire screen
//                    .onTapGesture {
//                        showCalendar = false // Close calendar when tapping outside
//                    }
//                CalendarView()
//                    .frame(width: 400, height: 500) // Adjust the frame as needed
//                    .padding(.top, 100)
//                   .background(Color.white)
//                   .cornerRadius(12)
//                   .shadow(radius: 10)
//                   .transition(.scale) // Optional transition effect when the calendar appears
//                   .zIndex(1) // Ensure the calendar is in front
//            }
            
           
            if isRideOffer {
                CalendarBar(selectedDate: $selectedDate)
                    .frame(height: 55) // Fixed height for CalendarBar
//                    .padding(.top, -1)
            } else {
                RideRequestBar()
                    .frame(height: 55) // Fixed height for RideRequestBar
//                    .padding(.top, -30)
            }

//
            Divider()
                .frame(height: 1)
                .background(Color.black)
                .padding(.top, -10)
            
            HStack{
                SearchBarView(defaultText: "Search for requests").frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)

                Image(isRideOffer ? "Hail" : "Bicycling")
                    .resizable()
                    .scaledToFit()
                    .frame(width:24, height:24)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 16)
                
                Text("\(rideCount)")
                    .foregroundColor(.black)  // Text color inside the button
                    .font(.system(size: 14, weight: .bold))
                    .padding(.trailing, 16)
                    .padding(.leading, -16)
                
                Image("filter")
                    .resizable()
                    .scaledToFit()
                    .frame(width:24, height:24)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 16)
                
                   
            }
            .onChange(of: selectedDate) { newDate in
                        Task {
                            rideCount = await fetchRideCount(for: newDate)
                        }
                    }
            .onAppear {
                        // Fetch ride count when the view appears
                        Task {
                            rideCount = await fetchRideCount(for: selectedDate)
                        }
                    }
            
            ZStack{
                
                ScrollCardsView()
                    .frame(maxHeight: .infinity)
                    .frame(minHeight: 100)
                
                Spacer()
                
                Button(action: {
                    RequestRide = true
                }) {
                    HStack(alignment: .center, spacing: 0) {
                        // Add your button content here (e.g., Text, Image, etc.)
                        Text(isRideOffer ? "Request a ride": "Offer a ride")
                            .foregroundColor(.black)  // Text color inside the button
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(16)
                    .frame(height: 40, alignment: .center)
                    .background(Color(red: 1, green: 0.75, blue: 0.12))  // Background color
                    .cornerRadius(20)  // Rounded corners
                    .shadow(color: .black.opacity(0.3), radius: 4.5, x: 0, y: 0)  // Shadow effect
                    .shadow(color: .black.opacity(0.2), radius: 2.5, x: 0, y: 2)  // Additional shadow
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.75)  // Border inset to create thickness
                            .stroke(Color.black, lineWidth: 1.5)  // Border stroke color and width
                    )}.padding(.top, 450).padding(.bottom, 13)
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
        .navigationDestination(isPresented: $NavCommunity) {
            OnboardingController2()  // Destination for Community
        }
        .navigationDestination(isPresented: $NavProfile) {
            OnboardingController2()  // Destination for Profile
        }
    }
}

// Function to fetch ride count based on selectedDate
func fetchRideCount(for selectedDate: Date) async -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateFormatter.string(from: selectedDate)
    
    guard let url = URL(string: "http://something/date?date=\(dateString)") else {
        return 0 // Return 0 if the URL is invalid
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let rideCount = try? JSONDecoder().decode(Int.self, from: data) {
            return rideCount // Return the ride count if decoding succeeds
        } else {
            return 0 // Return 0 if decoding fails
        }
    } catch {
        return 0 // Return 0 if there's an error (e.g., network failure)
    }
}



struct ExploreRides_Previews: PreviewProvider {
    static var previews: some View {
        ExploreRides()
    }
}
