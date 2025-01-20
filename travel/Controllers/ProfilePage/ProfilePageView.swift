//
//  ProfilePageView.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.
//

import SwiftUI
import Foundation

struct ProfilePageView: View {
    @State private var NavHome = false
    @State private var NavCommunity = false
    @State private var NavProfile = false
    @StateObject var userManager = UserManager.shared
    @StateObject private var imageFetcher = ImageFetcher()
    
    var body: some View {
        let user = userManager.user
        let warmYellow = Color(red: 1, green: 0.88, blue: 0.79)
      
            
            ZStack{//Z1
                ZStack{
                    VStack {//V1.1 top background
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: .infinity, height: 157)
                            .background(warmYellow)
                        
                        Divider()
                            .frame(width: .infinity, height: 1.5)
                            .background(Color.black)
                            .padding(.top, -10)
                    }//end V1.1
                    
                    Image("CarAndTree")
                        .resizable()
                        .aspectRatio(5/1, contentMode: .fit) // Replace 16/9 with your image's actual aspect ratio
                        .frame(maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .frame(alignment:.top)
                        .padding(.top,-80)
                }.frame(maxHeight: .infinity, alignment: .top)
                   

                VStack{ //VStack2
                Spacer().frame(height:140)
                    HStack{//HStack2.1
                        if let image = imageFetcher.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 119, height: 119)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(warmYellow, lineWidth: 10))
                                .overlay(
                                    HalfCircle()
                                        .stroke(Color.black, lineWidth: 2) // Bottom half black outline
                                        .frame(width: 126, height: 126)
                                        .offset(y: -60) // Position the half-circl
                                        )
                            
                        } else {
                            Image("profile_icon")
                                .frame(width: 119, height: 119)
                                .foregroundColor(.white)
                                .clipShape(Circle()) // Make the image circular
                                .overlay(Circle().stroke(warmYellow, lineWidth: 10))
                                .overlay(
                                    HalfCircle()
                                        .stroke(Color.black, lineWidth: 2) // Bottom half black outline
                                        .frame(width: 126, height: 126)
                                        .offset(y: -60) // Position the half-circl
                                        )
                                .onAppear {
                                    imageFetcher.fetchImage(from: user.profilePicURL)
                                }
                        }
                        
                        Spacer().frame(width: 30)
                        VStack{//VStack2.2
                            Text("\(user.name)")
                                .frame(maxWidth:.infinity, alignment:.leading)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                                
                                .padding(.bottom, 8)
                            
                            Text("\(user.pronouns) • \(user.grade) • \(user.location)")
                                .frame(maxWidth:.infinity, alignment:.leading)
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                .frame(alignment:.leading)
                            
                            HStack{//HStack2.2.1
                                Image("Phone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                
                                Text("\(user.phoneNumber)")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .frame(alignment:.leading)
                                //End HStack2.2.1
                            }.frame(maxWidth:.infinity, alignment:.leading)
                            
                            HStack{//HStack2.2.2
                                Image("Chat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    
                                
                                Text("Message")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .frame(alignment:.leading)
                                
                                Spacer()
                                Image("Settings")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                                    
                                //End HStack2.2.1
                            }.frame(maxWidth:.infinity, alignment:.leading)
                            //End VStack 2.2
                        }
                        .frame(maxWidth: 200)
                        //End HStack 2.1
                    }
                    
                    HStack{
                        RoundedButton(imageName: "panda1", buttonText: "\(user.rideOffers.count) ride offers")
                            .frame(maxWidth:.infinity, alignment:.leading)
                        RoundedButton(imageName: "panda2", buttonText: "\(user.rideOffers.count) ride requests")
                        
                        RoundedButton(imageName: "panda3", buttonText: "\(user.rideOffers.count) past trips")
                            .frame(maxWidth:.infinity, alignment:.trailing)
                    }.padding(.leading, 16)
                        .padding(.trailing, 16)
                      
                    HStack{
                        Text("Traveling Preferences")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(alignment:.leading)
                        
                        Spacer()
                        Image("Edit")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            
                    }.padding(16)
                        .padding(.bottom, -16)
                    
                    VStack{//VStack3
                        HStack{
                            Text("Quiet")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .frame(alignment:.leading)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Text("Talkative")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .frame(alignment:.leading)
                                .multilineTextAlignment(.trailing)
                        }.frame(maxWidth:.infinity, alignment:.leading)
                            .padding(.leading, 32)
                            .padding(.trailing, 32)
                            .padding(.bottom, -10)
                            .padding(.top, 16)
                        
                        
                        SnapSlider(width: 313, numTicks: 5)
                        
                        HStack{
                            Image("MusicNotes")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Text("\(user.musicPreference)")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .frame(alignment:.leading)
                                .multilineTextAlignment(.leading)
                        }.frame(maxWidth:.infinity, alignment:.leading)
                            .padding(.leading, 16)
                        
                        HStack{
                            Image("Funsies")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Text("\(user.funFact)")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                                .frame(alignment:.leading)
                                .multilineTextAlignment(.leading)
                        }.frame(maxWidth:.infinity, alignment:.leading)
                            .padding(.leading, 16)
                            .padding(.bottom, 16)
                            
                            
                        //End VStack3
                    }.overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 2) )
                    .padding(16)

                    
                    
                    BottomNavigationBar(
                        NavHome: $NavHome,
                        NavCommunity: $NavCommunity,
                        NavProfile: $NavProfile
                    )
                
                .navigationDestination(isPresented: $NavHome) {
                    ExploreRides()  // Destination for Home
                }
                .navigationDestination(isPresented: $NavCommunity) {
                    OnboardingController2()  // Destination for Community
                }
                .navigationDestination(isPresented: $NavProfile) {
                    OnboardingController2()  // Destination for Profile
                }
                 
                    //End VStack 2
                }.frame( maxHeight: .infinity, alignment: .top)
                

            }//Z1
          
    
    }
}

struct HalfCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY), radius: rect.width / 2, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
        return path
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
