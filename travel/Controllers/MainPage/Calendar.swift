import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    private let calendar = Calendar.current
    let grey = Color(red: 0.07, green: 0.27, blue: 0.41).opacity(0.5)
    var body: some View {
        VStack {
            // Month and Year Header
            Text(monthYearTitle)
                .font(.headline)
                .padding()
            
            // Days of the Week
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 5)
            
            // Calendar Days Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(daysInMonth, id: \.self) { day in
                    Text(day == 0 ? "" : "\(day)") // Empty cells for padding
                        .frame(width: 40, height: 40)
                        .background(day == selectedDay ? Color.blue : Color.clear)
                        .cornerRadius(20)
                        .foregroundColor(day == selectedDay ? .white : .primary)
                        .onTapGesture {
                            if day != 0 { selectDate(day: day) }
                        }
                }
            }
            .padding()
        }
        .padding(16) // Inner padding from the edges
        .overlay(
            // Add a black rectangle frame around the calendar
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
        )
//        .background(grey)
        .padding(16) // Outer padding to keep the rectangle 16px from the screen edges
    }
    
    // MARK: - Computed Properties
    
    private var selectedDay: Int {
        calendar.component(.day, from: selectedDate)
    }
    
    private var monthYearTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }
    
    private var daysOfWeek: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.shortWeekdaySymbols
    }
    
    private var daysInMonth: [Int] {
        guard let range = calendar.range(of: .day, in: .month, for: selectedDate),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate)) else {
            return []
        }
        
        let padding = calendar.component(.weekday, from: firstDay) - calendar.firstWeekday
        return Array(repeating: 0, count: padding < 0 ? padding + 7 : padding) + Array(range)
    }
    
    // MARK: - Methods
    
    private func selectDate(day: Int) {
        guard let newDate = calendar.date(bySetting: .day, value: day, of: selectedDate) else { return }
        selectedDate = newDate
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
