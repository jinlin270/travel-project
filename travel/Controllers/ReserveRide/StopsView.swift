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
            VStack(alignment: .leading, spacing: 10) {
                ForEach(stops.indices, id: \.self) { index in
                    HStack(alignment: .center) {
                        Text(arrivalTimes[index], style: .time)
                            .frame(width: 70, alignment: .leading)
                        
                        ZStack {
                            if index < stops.count - 1 { // Draw the connecting line
                                Rectangle()
                                    .frame(width: 2, height: 40)
                                    .foregroundColor(.black)
                                    .offset(y: 20) // Align below the current image
                            }
                            
                            Image(systemName: iconName(for: index))
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                        Text(stops[index])
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding()
        }
    }
    
    private func iconName(for index: Int) -> String {
        if index == 0 {
            return "arrow.down"
        } else if index == stops.count - 1 {
            return "circle.fill"
        } else {
            return "circle"
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
