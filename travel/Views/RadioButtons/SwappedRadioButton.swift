//
//  SwappedRadioButton.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

struct SwappedRadioButton: View {
    @Binding var isSelected: Bool
    let text: String

    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.black)
            Spacer()
            Button(action: {
                isSelected.toggle()
            }) {
                Image(isSelected ? "selectedRadioButton" : "RadioButton")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(PlainButtonStyle()) // Removes any default button styles
        }
        .padding(.horizontal)
    }
}

struct SwappedRadioButtonView: View {
    @State private var selectedOption: Int? = nil
    let options: [String]  // List of texts for the buttons

    var body: some View {
        VStack {
            ForEach(options.indices, id: \.self) { index in
                SwappedRadioButton(
                    isSelected: Binding(
                        get: { selectedOption == index },
                        set: { isSelected in
                            selectedOption = isSelected ? index : nil
                        }
                    ),
                    text: options[index]
                )
            }
        }
    }
}

struct SwappedRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        SwappedRadioButtonView(options: ["Option 1", "Option 2", "Option 3"])
    }
}
