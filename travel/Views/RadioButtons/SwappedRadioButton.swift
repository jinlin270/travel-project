//
//  SwappedRadioButton.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI

struct SwappedRadioButtonView: View {
    @Binding var selection: String
    let options: [String]  // List of texts for the buttons

    var body: some View {
        VStack {
            ForEach(options, id: \.self) { option in
                Button(action: { self.selection = option }) {
                    HStack {
                        Text(option)
                        Spacer()
                        Image(self.selection == option ? "selectedRadioButton" : "RadioButton")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
            }
        }
    }
}

struct SwappedRadioButton_Previews: PreviewProvider {
    @State static var previewSelection = "Option 1"

    static var previews: some View {
        SwappedRadioButtonView(selection: $previewSelection, options: ["Option 1", "Option 2", "Option 3"])
    }
}
