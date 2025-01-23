//
//  SearchButton.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import SwiftUI

struct SearchButtonView: View {
    @State private var searchText: String = ""
    let defaultText: String

    var body: some View {
        HStack(alignment: .center, spacing: 0) {  // Set spacing to 0 to reduce space
            // TextField with default text
            Text(defaultText)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.black)
                .opacity(0.5)
                .frame(alignment: .center)
                .padding(.trailing, 8)
               
            
            // Magnifier Image placed directly next to the TextField with minimal space
            Image("Magnifer")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(0) // Remove padding for the image
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(width: 255, height: 32, alignment: .center)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, lineWidth: 2)
        )
    }
}


struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView(defaultText: "Search Stuff")
            .padding()
    }
}

