//
//  CheckoutView.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//

import SwiftUI

struct CheckoutView: View {
    @State private var NavHome = false
    @StateObject private var imageFetcher = ImageFetcher()
    
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
                        
                    HStack{
                        if let image = imageFetcher.image {
                            styledProfileImage(Image(uiImage: image))
                        } else {
                            styledProfileImage(Image("profile_icon"))
                                .onAppear {
                                    imageFetcher.fetchImage(from: user.profilePicURL)
                                }
                        }
                    }.overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    
                }
                .padding() // Optional padding around the VStack
            }//ScrollView
        }.navigationDestination(isPresented: $NavHome) {
            ExploreRides()
            
        }//VStack1
    }//View
    
    private func styledProfileImage(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
