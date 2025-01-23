//
//  CommunityBar.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import SwiftUI

struct CommunityBar: View {
    @State private var Groups = false
    @State private var Messages = false
    @State private var Notifications = false
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    Groups = true
                    Messages = false
                    Notifications = false

                }) {
                    HStack(spacing: 4) {
                        Image("UsersGroup") // Use the provided image name
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Groups") // Use the provided button text
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .frame(alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    Groups = false
                    Messages = true
                    Notifications = false
                }) {
                    
                    HStack(spacing: 4) {
                        Image("Dialog") // Use the provided image name
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Messages") // Use the provided button text
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .frame(alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    Groups = false
                    Messages = false
                    Notifications = true
                }) {
                    HStack(spacing: 4) {
                        Image("Bell") // Use the provided image name
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Notifications") // Use the provided button text
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .frame(alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }

                }
                
            }.padding(24)

            
            ZStack{
               
                HStack {
                    Divider()
                        .frame(width: 85, height: 3)
                        .background(Groups ? Color.black : Color.clear)
                
                    Spacer()
                    
                    Divider()
                        .frame(width: 85, height: 3)
                        .background(Messages ? Color.black : Color.clear)
                    
               
                    Spacer()
                    
                    Divider()
                        .frame(width: 85, height: 3)
                        .background(Notifications ? Color.black : Color.clear)
                }.frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 25)
                

                Divider()
                    .frame(height: 1)
                    .background(Constants.blue)
            }.padding(.top, -15)
        }
    }
}

struct CommunityBar_Previews: PreviewProvider {
    static var previews: some View {
        CommunityBar()
    }
}

