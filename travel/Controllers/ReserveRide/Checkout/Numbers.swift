//
//  Numbers.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//

import SwiftUI

struct Numbers: View {
    var number: String
    var label: String
    
    var body: some View {
        HStack{
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 26.66667, height: 26.66667)
                    .background(Constants.blue)
                    .cornerRadius(5)
                
                Text("\(number)")
                    .foregroundColor(.white) // White text color
                    .font(.system(size: 16, weight: .bold)) // Adjust font size and weight as needed
            }
            Spacer().frame(width: 16)
            Text("\(label)")
                .foregroundColor(.black)  // Text color inside the button
                .font(.system(size: 18, weight: .bold))
                .padding(.trailing, 16)
        }
    }
}
