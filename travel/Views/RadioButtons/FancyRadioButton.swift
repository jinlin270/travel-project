//
//  FancyRadioButton.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//
import SwiftUI

struct RadioButtonOption {
    let text: String
    let imageName: String
}

struct FancyRadioButton: View {
    @Binding var selectedOption: String
    let options: [RadioButtonOption]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(options, id: \.text) { option in
                FancyRadioButtonRow(option: option, isSelected: selectedOption == option.text) {
                    selectedOption = option.text
                }
            }
        }
    }
}

struct FancyRadioButtonRow: View {
    let option: RadioButtonOption
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 16) {
                

                Image(systemName: isSelected ? "square.fill" : "square")
                                    .foregroundColor(isSelected ? .blue : .black)

                // Text
                Text(option.text)
                    .frame(maxWidth: 156, alignment: .leading)
                    .lineLimit(nil) // Allow wrapping
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)

                Spacer()

                // Image to the right of the text
                Image(option.imageName)
                    .resizable()
                    .frame(width: 90, height: 60)
                    .cornerRadius(8)
                    .clipped()
            }
        }
        .buttonStyle(PlainButtonStyle()) // Removes default button style
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(width: 361, height: 88, alignment: .leading)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.white)   // Highlight selected
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
    }
}
