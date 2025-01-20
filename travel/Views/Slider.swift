//
//  Slider.swift
//  travel
//
//  Created by Lin Jin on 1/20/25.
//
import SwiftUI

struct SnapSlider: View {
    @State private var dragLocation: CGPoint = .zero
    let width: CGFloat // Input for the slider width
    let numTicks: Int
    let warmYellow = Color(red: 1, green: 0.88, blue: 0.79)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                let barWidth = width - 20 // Bar width with padding on both sides
                let leftPadding = (geometry.size.width - barWidth) / 2
                var closestPosition = 0.0
                
                // Slider bar
                Rectangle()
                    .fill(warmYellow)
                    .frame(width: barWidth, height: 6)
                    .cornerRadius(12)
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 2).cornerRadius(12))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Center the bar
                
                // Dynamic Tick Marks
                ForEach(0...numTicks, id: \.self) { index in
                    let tickX = barWidth * CGFloat(index) / (CGFloat(numTicks)-1.0) + leftPadding
                    Circle()
                        .fill(Color.black)
                        .frame(width: 1, height: 1)
                        .position(x: tickX, y: geometry.size.height / 2)
                }
                
                // Thumb
                Circle()
                    .fill(Color.brown)
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                    .frame(width: 20, height: 20)
                    .position(x: dragLocation.x, y: geometry.size.height / 2)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                let clampedX = min(max(gesture.location.x, leftPadding + 10), leftPadding + barWidth - 10)
                                dragLocation = CGPoint(x: clampedX, y: geometry.size.height / 2)
                            }
                            .onEnded { gesture in
                                let clampedX = min(max(gesture.location.x, leftPadding + 10), leftPadding + barWidth - 10)
                                
                                // Calculate positions for all tick marks
                                let tickPositions = (0...numTicks).map { index in
                                    barWidth * CGFloat(index) / (CGFloat(numTicks)-1.0) + leftPadding
                                }
                                
                                // Find the closest tick position
                                closestPosition = tickPositions.min(by: { abs($0 - clampedX) < abs($1 - clampedX) }) ?? 0
                                dragLocation = CGPoint(x: closestPosition, y: geometry.size.height / 2)
                            }
                    )
            }
            .onAppear {
                // Initialize dragLocation to the center of the bar
                let centerX = geometry.size.width / 2
                dragLocation = CGPoint(x: centerX, y: geometry.size.height / 2)
            }
            .frame(width: width, height: 40) // Set the overall width dynamically
        }
        .frame(height: 40)
    }
}

// Preview provider for testing
struct SnapSlider_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            SnapSlider(width: 300, numTicks: 5) // Slider with a width of 300
                .padding()
            SnapSlider(width: 200, numTicks: 5) // Slider with a width of 200
                .padding()
        }
    }
}
