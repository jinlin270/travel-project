//
//  StopsView.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//

import SwiftUI

struct StopsView: View {
    let stops: [String]
    let arrivalTimes: [Date]
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    // Draw the connecting line from top to bottom
                    Rectangle()
                        .frame(width: 2, height: geometry.size.height)
                        .foregroundColor(.black)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    // Overlay the stops and images
                    VStack(spacing: 10) {
                        ForEach(stops.indices, id: \.self) { index in
                            HStack {
                                Text(arrivalTimes[index], style: .time)
                                    .frame(width: 60, alignment: .leading)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Image(iconName(for: index))
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .background(Color.white)
                                    .padding(.leading, -22)
                                
                                Spacer()
                                
                                VStack{
                                    Text(stops[index])
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                    Text(stops[index])
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(height: 30) // Set consistent height for each row
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .frame(minHeight: CGFloat(stops.count * 40)) // Ensure enough height for the line
            .padding()
        }
    }
    
    private func iconName(for index: Int) -> String {
        if index == 0 {
            return "MapArrowDown"
        } else if index == stops.count - 1 {
            return "destination"
        } else {
            return "stop"
        }
    }
}

struct StopsView_Previews: PreviewProvider {
    static var previews: some View {
        StopsView(
            stops: ["Stop 1", "Stop 2", "Stop 3", "Stop 4"],
            arrivalTimes: [
                Date(),
                Date().addingTimeInterval(3600),
                Date().addingTimeInterval(7200),
                Date().addingTimeInterval(10800)
            ]
        )
    }
}
