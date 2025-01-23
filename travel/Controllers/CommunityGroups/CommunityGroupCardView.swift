//
//  CommunityGroupCardView.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import SwiftUI
struct CommunityGroupCardView: View {
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
                    
                    Image(systemName: "plus")
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
                    
                    Text("\(group.numMembers)")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(alignment: .leading)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    
                    
                    Image("Hail")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .cornerRadius(12)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 1)
                        )
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
    

let group1 = GroupModel(id: 1, groupName: "Cornell 2025", profilePicture: "https://cdn.britannica.com/08/235008-050-C82C6C44/Cornell-University-Uris-Library-Ithaca-New-York.jpg", isPublic: true, numMembers: 10, filterTags: Set(arrayLiteral: "Popular"), latitude: Double(42.4534), longitude: Double(76.4735))

struct CommunityGroupCardView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityGroupCardView(group: group1)
    }
}
