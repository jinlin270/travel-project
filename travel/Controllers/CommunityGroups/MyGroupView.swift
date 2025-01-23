//
//  MyGroupView.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import SwiftUI
struct MyGroupCardView: View {
    var group: GroupModel
    @StateObject private var imageFetcher = ImageFetcher()
    
    
    var body: some View {
        HStack{
            if let image = imageFetcher.image {
                styledProfileImage(Image(uiImage: image))
            } else {
                styledProfileImage(Image("panda1"))
                    .onAppear {
                        imageFetcher.fetchImage(from: group.profilePicture)
                    }
            }
            
            Spacer().frame(width: 16)
            VStack{
                HStack{
                    Text("\(group.groupName)") // Use the provided button text
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    
                    Image("unreadChat")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .cornerRadius(12)
                }
                
                
                HStack{
                    Text(group.isPublic ? "Public group" : "Private group")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth:.infinity, alignment: .leading)
                    
                    Spacer()
                    
                    //TODO: Make number correspond to num unread texts
                    Text("10+ new")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(alignment: .leading)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    
                }
            }
        
        }
    
    }
    private func styledProfileImage(_ image: Image) -> some View {
        image
            .resizable()
            .frame(width: 75, height: 48)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}
    

struct MyGroupCardView_Previews: PreviewProvider {
    static var previews: some View {
        MyGroupCardView(group: group1)
    }
}
