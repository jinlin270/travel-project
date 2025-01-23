//
//  CalendarBar.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.
//
import SwiftUI

struct CalendarBar: View {
    @Binding var selectedDate :Date // Currently selected date
    @State private var scrollPosition = 0 // Centered index in the carousel
    @State private var visibleStartDate = Date() // Starting date for the visible days
    @State private var ridesData: [Date: Int] = [:] // Store the rides count for each day
    private let calendar = Calendar.current
    private let daysToShow = 30 // Total number of days available
    private let visibleDatesCount = 5 // Number of visible dates to show at once
    
    var body: some View {
        VStack {
            carouselView
    
            longDivider
        }
        .padding()
        .onAppear { fetchRideData() }
    }
    
    // MARK: - Carousel View
    private var carouselView: some View {
        GeometryReader { geometry in
            HStack {
                arrowButton(direction: .left, action: moveLeft, isDisabled: scrollPosition == 0, isLeftArrow: true, geometry: geometry)
                
                carouselDates(in: geometry)
                
                arrowButton(direction: .right, action: moveRight, isDisabled: scrollPosition >= daysToShow - visibleDatesCount, isLeftArrow: false, geometry: geometry)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
    }
    
    private func arrowButton(direction: ArrowDirection, action: @escaping () -> Void, isDisabled: Bool, isLeftArrow: Bool, geometry: GeometryProxy) -> some View {
        Button(action: action) {
            Image(direction.image)
                .font(.system(size: 24))
                .foregroundColor(.black)
        }
        .disabled(isDisabled)
        .frame(maxHeight: .infinity) // Allow the button to be vertically centered
        .position(x: isLeftArrow ? geometry.safeAreaInsets.leading + 8 :  geometry.safeAreaInsets.trailing - 8,
                  y: geometry.size.height / 2)
    }
    
    private func carouselDates(in geometry: GeometryProxy) -> some View {
        HStack(spacing: 0) {
            ForEach(getVisibleDates(), id: \.self) { date in
                dateView(for: date)
                    .frame(width: geometry.size.width / CGFloat(visibleDatesCount), height: 100) // Flexible width based on screen size
                    .contentShape(Rectangle())
                    .onTapGesture { selectedDate = date }
            }
        }
        .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Align carousel horizontally and vertically
        
        .frame(width: geometry.size.width, alignment: .center)
    }

    private func dateView(for date: Date) -> some View {
        VStack {
            Text(getDayOfWeek(for: date))
                .font(.system(size: 12))
                .foregroundColor(.black)
            
            ZStack {
                if isToday(date) {
                    Circle()
                        .fill(isSameDay(date1: date, date2: selectedDate) ? Color.blue.opacity(0.4) : Color.blue.opacity(0.3))
                        .frame(width: 22, height: 22)
                }
                
                Circle()
                    .fill(isSameDay(date1: date, date2: selectedDate) ? Color.orange.opacity(0.2) : Color.clear)
                    .frame(width: 22, height: 22)
                
                Text(getDayOfMonth(for: date))
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                
                
            }
            
            Text("\(ridesData[date] ?? 0) rides")
                .font(.system(size: 10))
                .foregroundColor(.black)
            
            if isSameDay(date1: date, date2: selectedDate) {
                Divider()
                    .frame(width: 52, height: 3)
                    .background(Color.black)
            }else{
                
                Divider().frame(width: 52, height: 2)
                    .background(Color.clear)
            }
        }
        .padding(0)
        .frame(height: 100) // Ensure the height is constant, no dynamic resizing here
    }

    // MARK: - Long Divider
    private var longDivider: some View {
        Divider().frame(height: 1).background(Color.black)
            .padding(.top, 8) // Adjust this value to move the divider closer to the dates
            .frame(maxWidth: .infinity)
            .alignmentGuide(.top) { d in d[.top] }
            .offset(y: -340) // Adjust the Y offset to align it with the short dividers
    }

    // MARK: - Scroll Logic
    private func getVisibleDates() -> [Date] {
        var allDates: [Date] = []
        for offset in 0..<daysToShow {
            if let date = calendar.date(byAdding: .day, value: offset, to: visibleStartDate) {
                allDates.append(date)
            }
        }
        
        let startIndex = max(0, scrollPosition)
        let endIndex = min(startIndex + visibleDatesCount, allDates.count)
        return Array(allDates[startIndex..<endIndex])
    }
    
    private func moveLeft() {
        guard scrollPosition > 0 else { return }
        scrollPosition -= visibleDatesCount
        visibleStartDate = calendar.date(byAdding: .day, value: -visibleDatesCount, to: visibleStartDate) ?? visibleStartDate
    }
    
    private func moveRight() {
        guard scrollPosition < daysToShow - visibleDatesCount else { return }
        scrollPosition += visibleDatesCount
        visibleStartDate = calendar.date(byAdding: .day, value: visibleDatesCount, to: visibleStartDate) ?? visibleStartDate
    }
    
    // MARK: - Date Helper Functions
    private func getDayOfWeek(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private func getDayOfMonth(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        calendar.isDate(date1, inSameDayAs: date2)
    }
    
    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
    
    // MARK: - Data Fetching
    private func fetchRideData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let monthURL = URL(string: "http://someapi/month")!
        URLSession.shared.dataTask(with: monthURL) { data, response, error in
            if let data = data, error == nil, let rides = try? JSONDecoder().decode([String: Int].self, from: data) {
                DispatchQueue.main.async {
                    rides.forEach { dateString, rideCount in
                        if let date = dateFormatter.date(from: dateString) {
                            ridesData[date] = rideCount
                        }
                    }
                }
            }
        }.resume()

        getVisibleDates().forEach { date in
            let dayURL = URL(string: "http://someapi/day?date=\(dateFormatter.string(from: date))")!
            URLSession.shared.dataTask(with: dayURL) { data, response, error in
                if let data = data, error == nil, let rideCount = try? JSONDecoder().decode(Int.self, from: data) {
                    DispatchQueue.main.async {
                        ridesData[date] = rideCount
                    }
                }
            }.resume()
        }
    }
}

enum ArrowDirection {
    case left, right
    
    var image: String {
        switch self {
        case .left: return "Alt Arrow Left"
        case .right: return "Alt Arrow Right"
        }
    }
}


