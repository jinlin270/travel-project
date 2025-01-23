//
//  SearchBar.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import SwiftUI

struct SearchBar: View {
    @State var searchText: String = ""
    @State private var isEditing: Bool = false // Tracks whether the user is editing the search bar
    
    var placeholder: String = "Search for groups"
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $searchText)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .onTapGesture {
                    withAnimation {
                        isEditing = true
                    }
                }
            
            Button(action: {
                //Todo: add backend for searching
            }) {
                Image("Magnifer")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 16)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
        )
        .frame(width: 233)
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        SearchBar()
            .onChange(of: text) { newValue in
                // This will print the new value of 'text' whenever it changes
                print("Text changed to: \(newValue)")
            }
    }
}
