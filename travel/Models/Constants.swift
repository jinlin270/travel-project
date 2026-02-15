//
//  Constants.swift
//  travel
//
//  Created by Lin Jin on 1/23/25.
//

import SwiftUI
struct Constants {
    // MARK: - Colors
    static let blue: Color = Color(red: 0.07, green: 0.27, blue: 0.41)
    static let main4: Color = Color(red: 0, green: 0.12, blue: 0.19)
    static let warmYellow = Color(red: 1, green: 0.88, blue: 0.79)
    static let highlighterYellow = Color(red: 1, green: 0.75, blue: 0.12)

    // MARK: - API
    // Simulator: localhost works directly.
    // Physical device: replace with your Mac's LAN IP (e.g. http://192.168.1.x:8080)
    static let baseURL = "http://localhost:8080/api/v1"
}
