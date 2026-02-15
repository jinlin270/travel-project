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
        HStack(spacing: 16) {
            if let image = imageFetcher.image {
                styledProfileImage(Image(uiImage: image))
            } else {
                styledProfileImage(Image("panda1"))
                    .onAppear {
                        imageFetcher.fetchImage(from: group.profilePicture)
                    }
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text(group.groupName)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(1)

                    Spacer(minLength: 8)

                    Image("unreadChat")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .cornerRadius(12)
                }

                HStack(spacing: 8) {
                    Text(group.isPublic ? "Public group" : "Private group")
                        .font(.system(size: 12))
                        .foregroundColor(.black)

                    Spacer(minLength: 8)

                    //TODO: Make number correspond to num unread texts
                    Text("10+ new")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
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
