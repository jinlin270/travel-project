//
//  ViewGuests.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.
//

import SwiftUI

func profilePicsView(for users: [User]) -> some View {
    HStack {
        ForEach(users.prefix(2), id: \.id) { user in
            AsyncImage(url: URL(string: user.profilePicURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 5)
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }
        }
        
        // Show "+" if there are more than 2 users
        if users.count > 2 {
            Text("+\(users.count - 2)")
                .foregroundColor(.black)
                .font(.system(size: 12, weight: .bold))
                .frame(height: 20)
        }
    }
}

