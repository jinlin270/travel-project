//
//  UploadPicture.swift
//  travel
//
//  Created by Lin Jin on 1/17/25.
//
import SwiftUI

struct UploadPictureView: View {
    //TODO: UploadPic left as input so it could upload to different backend apis as per use case
    let UploadPic: () -> Void
    
    let grey = Color(red: 0.07, green: 0.27, blue: 0.41).opacity(0.5)
    // TODO: implement browsepic to allow user to browse their picture
    func BrowsePic() { }
    
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(.clear)  // Make the background transparent
                .frame(width: 361, height: 247)  // Set the dimensions
                .background(Color(red: 0.92, green: 0.92, blue: 0.92))  // Set background color
                .cornerRadius(4)  // Apply corner radius
                .overlay(
                    RoundedRectangle(cornerRadius: 4)  // Overlay with a rounded rectangle for the border
                        .inset(by: 0.5)  // Inset the border by 0.5
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))  // Dashed border
                )
                .overlay(
                    Image("grey_circle")  // Add image with the name "img1"
                        .resizable()
                        .scaledToFit()
                        .frame(width: 119, height: 119)  // Set image size
                        .position(x: 361 / 2, y: 80))
                .overlay(
                    Text("Browse")
                        .font(
                            Font.custom("DM Sans", size: 16)
                                .weight(.bold)
                        )
                        .kerning(0.15)
                        .multilineTextAlignment(.center)
                        .position(x: 361 / 2, y: 163)  // Position below the image, 16px tall font
                )
                .overlay(
                    Text("Supported formats: JPEG, PNG, PDF and JPG")
                        .font(Font.custom("DM Sans", size: 12))
                        .kerning(0.2)
                        .multilineTextAlignment(.center)
                        .position(x: 361 / 2, y: 215)
                )
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            BrowsePic()  // Call the action when tapped
                        }
                )
            Spacer().frame(height: 24)
            
            Button(action: {
                UploadPic()
            }) {
                Text("Upload")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 50) // Size
                    .background(grey) // Background color
                    .cornerRadius(24) // Rounded corners
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(grey, lineWidth: 1) // Border
                    ).padding(.leading, 10)
            }
        }
    }
}
