//
//  DriverInfoView.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//


import SwiftUI
struct DriverInfoView: View {
    var driver: User
    @StateObject private var imageFetcher = ImageFetcher()
    
    var body: some View {

            
            VStack(){
                // VStack1 (Top VStack)
                
                HStack {
                    //HStack1 (profile)
                    if let image = imageFetcher.image {
                        styledProfileImage(Image(uiImage: image))
                    } else {
                        styledProfileImage(Image("profile_icon"))
                            .onAppear {
                                imageFetcher.fetchImage(from: user1.profilePicURL)
                            }
                    }
                    
                    Spacer().frame(width:13)
                    VStack{
                        //VStack2 (name and review)
                        HStack{
                            Text(driver.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image("star")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text(String(driver.rating))
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            Image("dot")
                                .resizable()
                                .frame(width: 3, height: 3)
                            
                            Text("\(driver.numRatings) reviews")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                .underline()
                           
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)
                        
                        Spacer().frame(height:4)
                        
                        Text("\(driver.grade) at ")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{//HStack2.2.1
                            HStack{
                                Image("Phone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Text("Message")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            HStack{
                                Image("Chat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Text("Phone")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            HStack{
                                Image("User")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Text("Profile")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                        }.padding(.trailing, 16)
                        
                    }//end of VStack1 (name and review)
                    
                } //end of HStack1 (profile)
                .padding(.leading, 16)
                
                Spacer().frame(height:8)
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal, 16)
                
                Spacer().frame(height:8)
                
                
            } //end of VStack1 (Overall Sections)
            .padding(.top, 16)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 12)
        
    }
    private func styledProfileImage(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 72, height: 72)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
    }
}


struct DriverInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DriverInfoView(driver: user1)
            .previewDevice("iPhone 14") // You can adjust this to your preferred device
            .previewLayout(.sizeThatFits) // Makes the preview fit content size
    }
}
