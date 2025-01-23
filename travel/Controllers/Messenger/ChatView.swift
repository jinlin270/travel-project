//
//  ChatView.swift
//  travel
//
//  Created by Lin Jin on 1/22/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    
    var body: some View {
        VStack {
            // Correct usage of List
            List(viewModel.messages) { message in
                HStack {
                    VStack(alignment: .leading) {
                        Text(message.sender.name)
                            .font(.headline)
                        Text(message.content)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("\(message.timestamp, style: .time)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 5)
            }
            .listStyle(PlainListStyle())
            
            // Message input and send button
            HStack {
                TextField("Enter message", text: $viewModel.currentMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                Button(action: {
                    viewModel.sendMessage()
                }) {
                    Text("Send")
                        .font(.headline)
                }
                .padding(.trailing)
                .disabled(viewModel.currentMessage.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Group Chat")
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatViewModel(currentUser: user))
    }
}
