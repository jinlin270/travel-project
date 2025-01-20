//
//  Buttons.swift
//  travel
//
//  Created by Lin Jin on 1/20/25.
//

import SwiftUI

struct RoundedButton: View {
    let imageName: String
    let buttonText: String

    var body: some View {
        Button(action: {
            // Add button action here
        }) {
            HStack(spacing: 8) {
                Image(imageName) // Use the provided image name
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(buttonText) // Use the provided button text
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .frame(alignment: .leading)
            }
            .padding()
        }
        .frame(height: 50) // Adjust height as needed
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2)
        )
        .cornerRadius(12)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(imageName: "panda1", buttonText: "1 ride request")
    }
}
