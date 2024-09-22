//
//  NavigationButtons.swift
//  travel
//
//  Created by Lin Jin on 12/29/24.
//

import SwiftUI

struct NavigationButtons: View {
    let onBack: () -> Void
    let onNext: () -> Void
    let blueColor = Color(UIColor(red: 0.07, green: 0.27, blue: 0.41, alpha: 1.0))
    var body: some View {
//         Back and Next Buttons
        HStack(spacing: 20) {
                Button(action: {
                    onBack()
                }) {
                    Text("Back")
                        .frame(width: 100, height: 50) // Size
                        .foregroundColor(blueColor) // Text color
                        .background(Color.clear) // Background color
                        .cornerRadius(24) // Rounded corners
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.black, lineWidth: 1) // Border
                        ).padding(.leading, 10)
                }
                Spacer()
                Button(action: {
                    onNext()
                }) {
                    Text("Next")
                        .frame(width: 100, height: 50) // Size
                        .foregroundColor(.white) // Text color
                        .background(blueColor) // Background color
                        .cornerRadius(24) // Rounded corners
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(blueColor, lineWidth: 3) // Border
                        ).padding(.trailing, 10)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 60)
    }
}
