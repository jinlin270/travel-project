//
//  MessageModel.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//
import SwiftUI

struct Message: Identifiable {
    var id: String
    var sender: User
    var content: String
    var timestamp: Date
}
