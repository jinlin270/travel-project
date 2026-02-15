//
//  ChatViewModel.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var currentMessage: String = ""
    
    var currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }

    func sendMessage() {
        let newMessage = Message(id: Int.random(in: Int.min..<0),
                                 sender: currentUser,
                                 content: currentMessage,
                                 timestamp: Date())
        messages.append(newMessage)
        currentMessage = "" // Clear the input after sending
    }
}
