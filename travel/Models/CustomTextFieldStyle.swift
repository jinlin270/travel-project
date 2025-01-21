//
//  CustomTextFieldStyle.swift
//  travel
//
//  Created by Lin Jin on 1/21/25.
//

import SwiftUI
// Custom text field style to match the appearance
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(Color.white)
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Constants.blue, lineWidth: 2)
            )
    }
}
