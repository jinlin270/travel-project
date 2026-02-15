//
//  UploadBox.swift
//  StuGo - travel
//
//  Reusable upload component with dashed border
//  Features:
//  - Dashed border rectangle
//  - Icon/placeholder in center
//  - Browse text
//  - Supported formats text
//  - Tap gesture support
//

import SwiftUI

struct UploadBox: View {
    let icon: String // SF Symbol name or "circle" for profile pic
    let browseText: String = "Browse"
    let onTap: () -> Void
    var isCircle: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.5)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                )
                .overlay(
                    VStack(spacing: 12) {
                        if isCircle {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 80, height: 80)
                        } else {
                            Image(systemName: icon)
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                        }

                        Text(browseText)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)

                        Text("Supported formats: JPEG, PNG, PDF and JPG")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                )
                .onTapGesture {
                    onTap()
                }
        }
    }
}

#Preview("Upload Icon") {
    UploadBox(icon: "icloud.and.arrow.up", onTap: {
        print("Tapped")
    })
    .padding()
}

#Preview("Profile Circle") {
    UploadBox(icon: "", onTap: {
        print("Tapped")
    }, isCircle: true)
    .padding()
}
