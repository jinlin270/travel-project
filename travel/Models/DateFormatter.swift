//
//  DateFormatter.swift
//  travel
//
//  Created by Lin Jin on 1/19/25.

import Foundation

extension DateFormatter {
    static let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a" // 'h' for hour (12-hour clock), 'a' for AM/PM
            return formatter
        }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d" // Example: Sun, Aug 9
        return formatter
    }()
}
