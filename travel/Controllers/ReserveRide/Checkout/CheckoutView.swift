//
//  CheckoutView.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//

import SwiftUI

struct CheckoutView: View {
    var tripInfo: TripInfo
    @State private var NavHome = false
    @StateObject private var imageFetcher = ImageFetcher()
    @ObservedObject var luggageModel = LuggageModel()
    @State private var coupon = ""
    
    var body: some View {
        VStack{//VStack1
            HStack{
                Button(action: {
                    NavHome = true
                }) {
                    Image("SimpleArrowLeft")
                        .resizable()
                        .scaledToFit()
                        .frame(width:24, height:24)
                        .padding(.leading, 16)
                }
                
                Spacer()
                Text("Checkout")
                    .foregroundColor(.black)  // Text color inside the button
                    .font(.system(size: 18, weight: .bold))
                    .padding(.trailing, 16)
                
            }.padding(.horizontal, 16)
            
            Divider()
                .frame(height: 1)
                .background(Color.black.opacity(0.5))
                            
            ScrollView {
                VStack() { // Adjust spacing as needed
                   
                    Numbers(number: "1", label: "Passenger Detail")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    
                    styleVStack(VStack{
                        HStack{
                            if let image = imageFetcher.image {
                                styledProfileImage(Image(uiImage: image))
                            } else {
                                styledProfileImage(Image("profile_icon"))
                                    .onAppear {
                                        imageFetcher.fetchImage(from: user.profilePicURL)
                                    }
                            }
                            Text("You")
                                .foregroundColor(.black)  // Text color inside the button
                                .font(.system(size: 14))
                                .padding(.horizontal, 16)
                            
                        }.padding(16)
                    })
                    
                    Numbers(number: "2", label: "Bags")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    
                    
                    styleVStack(VStack{
                        HStack{
                            VStack{
                                Text("Number of Bags")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                                    .padding(.horizontal, 16)
                                    .padding(.top, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                                
                                Text("Type")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Spacer()
                                
                                Text("Estimated Weight")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            VStack{
                                
                                TextField("0", text: $luggageModel.numBagsText)
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .onChange(of: luggageModel.numBagsText) { newValue in
                                        // When the input changes, only allow numeric values
                                        if let number = Int(newValue), number >= 0 {
                                            luggageModel.numBags = number
                                        } else {
                                            luggageModel.numBagsText = String(newValue.filter { $0.isNumber })
                                        }
                                    }
                                
                                TextField("Luggage", text: $luggageModel.bagType)
                                    .textFieldStyle(CustomTextFieldStyle())
                                
                                TextField("0", text: $luggageModel.weightText)
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .onChange(of: luggageModel.weightText) { newValue in
                                        // When the input changes, only allow numeric values
                                        if let number = Int(newValue), number >= 0 {
                                            luggageModel.weight = number
                                        } else {
                                            luggageModel.weightText = String(newValue.filter { $0.isNumber })
                                        }
                                    }
                            } //Luggage TextField VStack
                                
                        }.padding(16) //HStack Bag
                    })
                    
                    Numbers(number: "3", label: "Payment")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    
                    styleVStack(
                        VStack{
                            RegularRadioButtonView(options: ["Apple Pay", "Credit Card"], images: ["Apple Pay", "Visa"])
                                .padding(16)
                            
                            Button(action: {
                                        // Action for the button
                                        print("Button tapped!")
                                    }) {
                                        Text("Add another Method")
                                            .foregroundColor(.white) // White text color
                                            .font(.system(size: 16, weight: .bold)) // Bold font
                                            .padding() // Add padding inside the button
                                            .frame(maxWidth: .infinity) // Optional: Make the button fill available width
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Constants.blue) // Blue background
                                            )
                                    }.padding(.horizontal, 32)
                                .padding(.bottom, 16)
                        }
                    )
                    
                    Numbers(number: "4", label: "Price Details")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    
                    styleVStack(
                        VStack(){
                            HStack{
                                Text("Amount")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                                Spacer()
                                Text("$")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                            }.padding(16)
                            
                            HStack{
                                Text("Discount")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                                Spacer()
                                Text("$ 0")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                            }.padding(16)
                            
                            HStack{
                                Text("Got coupon?")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                                
                                Spacer()
                                
                                TextField("Code?", text: $coupon)
                                    .textFieldStyle(CustomTextFieldStyle()).frame(width:145)
                            }.padding(16)
                                .padding(.top, 0)
                            
                            
                            HStack{
                                Text("Total")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                                Spacer()
                                Text("$")
                                    .foregroundColor(.black)  // Text color inside the button
                                    .font(.system(size: 14))
                            }.padding(16)
                            
                        }
                    )
                    
                }
            }//ScrollView
            
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
                        // Action for the button
                        print("Button tapped!")
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

            //VStack1
        }
        .navigationDestination(isPresented: $NavHome) {
            ExploreRides()}
        .navigationBarHidden(true) //for hiding back button in uikit
        .navigationBarBackButtonHidden(true) //for hiding back button in swiftui
        
    }//View
    
    private func styleVStack(_ vStack: some View) -> some View {
        vStack
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2))
            .padding(16)
            
    }
    
    private func styledProfileImage(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
    }
}

