//
//  MessageModel.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//
import SwiftUI

struct Message: Identifiable, Decodable {
    var id: Int
    var sender: User
    var content: String
    var timestamp: Date
    var group: GroupModel?      // set for group messages
    var recipient: User?        // set for direct messages
}
