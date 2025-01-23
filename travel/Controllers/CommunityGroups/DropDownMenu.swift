//
//  DropDownMenu.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import SwiftUI

struct DropdownMenu: View {
    @Binding var selectedOption: String  // Default text
    @Binding var isMenuOpen: Bool// Tracks whether the menu is open
    
    let options = ["Popular", "Recommended", "Default", "hahah"]
    
    var body: some View {
        VStack {
            // Button that toggles the dropdown menu
            HStack {
                Button(action: {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    Text(selectedOption)
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                
                Image(isMenuOpen ? "Alt Arrow Down" : "Alt Arrow Right")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
            .cornerRadius(20)
            .frame(width: 120)
        }
        .overlay(
            // Dropdown menu overlay above the parent view
            Group {
                if isMenuOpen {
                    VStack(spacing: 0) {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                selectedOption = option // Update the button text
                                isMenuOpen = false // Close the menu
                            }) {
                                Text(option)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                    .lineLimit(1)
                            }
                        }
                    }
                    .background(Color.white) // Dropdown background
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .frame(width: 120)
                    .offset(y: 120) // Move the dropdown menu above the button
                    .zIndex(10) // Ensure it stays above other content
                }
            }
        )
        .frame(width: 120)
    }
}

