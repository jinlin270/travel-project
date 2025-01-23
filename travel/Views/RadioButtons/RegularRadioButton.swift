//
//  RegularRadioButton.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//

import SwiftUI

struct RegularRadioButton: View {
    @Binding var isSelected: Bool
    @StateObject private var imageFetcher = ImageFetcher()
    let text: String
    let buttonImage: String

    var body: some View {
        HStack {
            
            Button(action: {
                isSelected.toggle()
            }) {
                Image(isSelected ? "selectedRadioButton" : "RadioButton")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(PlainButtonStyle()) // Removes any default button styles
            
            Spacer().frame(width: 16)
            
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            Image(buttonImage)
                .resizable()
                .frame(width: 40, height: 40)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 16)

            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    

}

struct RegularRadioButtonView: View {
    @State private var selectedOption: Int? = nil
    let options: [String]  // List of texts for the buttons
    let images: [String]

    var body: some View {
        VStack {
            ForEach(options.indices, id: \.self) { index in
                RegularRadioButton(
                    isSelected: Binding(
                        get: { selectedOption == index },
                        set: { isSelected in
                            selectedOption = isSelected ? index : nil
                        }
                    ),
                    text: options[index],
                    buttonImage: images[index]
                )
            }
        }
    }
}

struct RegularRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RegularRadioButtonView(options: ["Option 1", "Option 2", "Option 3"], images: ["star", "panda2", "panda3"])
    }
}
