//
//  RequestRideForm.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

struct RequestRideForm: View {
    @StateObject private var viewModel = FilterViewModel()
    @State private var NavHome = false
    @State private var saveTrip: Bool = false

    var body: some View {

            
            VStack {//VStack1
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 64)
                    .background(Constants.blue)
                    .overlay(
                        HStack {
                            Button(action: {
                                viewModel.resetTextFields()
                            }) {
                                Text("Reset")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text("Request A Ride")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            Button(action: {
                                // Exit button action here
                                NavHome = true
                            }) {
                                Image("close2")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                            .padding(.horizontal)
                    )
                
                Spacer().frame(height: 30)
                
                FilterTextField(viewModel: viewModel)
                
                Spacer().frame(height: 30)
                
                Text("Who you want to travel with")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                SwappedRadioButtonView(options: ["All females", "All males", "Any"])
                
                Spacer().frame(height: 30)
                
                Text("Recurring")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                HStack{
                    Text("Once")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Daily")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Weekly")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Monthly")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Custom")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }.padding(16)  // Add padding for content
                    .background(Color(red: 1, green: 0.88, blue: 0.79).opacity(0.6))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                
                
                Spacer()
                
                HStack {
                    Text("Save for next trips")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.head)
                    
                    Toggle("", isOn: $saveTrip)
                        .tint(Constants.blue)
                        .padding(.leading, 16) // Set padding on the leading side of the Toggle to create 16px gap
                        .labelsHidden() // Hides the label of the Toggle to avoid extra spacing
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                Button(action: {
                    NavHome = true
                    //TODO: Backend post
                }) {
                    HStack(alignment: .center, spacing: 0) {
                        // Add your button content here (e.g., Text, Image, etc.)
                        Text("Post Request")
                            .foregroundColor(.white)  // Text color inside the button
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(16)
                    .frame(width: 361, height: 48, alignment: .center)
                    .background(Constants.blue)  // Background color
                    .cornerRadius(12)  // Rounded corners
                    .shadow(color: .black.opacity(0.3), radius: 4.5, x: 0, y: 0)  // Shadow effect
                    .shadow(color: .black.opacity(0.2), radius: 2.5, x: 0, y: 2)  // Additional shadow
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.75)  // Border inset to create thickness
                            .stroke(Color.black, lineWidth: 1.5)  // Border stroke color and width
                    )}
                
            } .navigationBarHidden(true) //for hiding back button in uikit
                .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
                .navigationDestination(isPresented: $NavHome) {
                    ExploreRides()}
               
    }
}

struct RequestRideForm_Previews: PreviewProvider {
    static var previews: some View {
        RequestRideForm()
    }
}
