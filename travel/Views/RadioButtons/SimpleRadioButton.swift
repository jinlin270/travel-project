//
//  SimpleRadioButton.swift
//  StuGo - travel
//
//  Simple radio button component for onboarding screens
//  Features:
//  - Circle indicator (filled when selected)
//  - Text label
//  - Tap to select
//

import SwiftUI

struct SimpleRadioButton: View {
    @Binding var isSelected: Bool
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Radio circle
            ZStack {
                Circle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 24, height: 24)

                if isSelected {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 14, height: 14)
                }
            }

            Text(text)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isSelected = true
        }
    }
}

#Preview("Unselected") {
    SimpleRadioButton(isSelected: .constant(false), text: "I would love to offer rides")
        .padding()
}

#Preview("Selected") {
    SimpleRadioButton(isSelected: .constant(true), text: "I would love to offer rides")
        .padding()
}
