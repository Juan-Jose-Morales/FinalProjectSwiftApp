//
//  MessageView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 22/7/24.
//

import SwiftUI

struct MessageView: View {
    @StateObject private var viewModel: MessageViewModel
    @State private var messageText: String = ""
    let chat: ChatList

    init(chat: ChatList) {
        _viewModel = StateObject(wrappedValue: MessageViewModel(chatId: chat.chat))
        self.chat = chat
    }

    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                VStack(alignment: .leading) {
                    Text(message.message)
                        .font(.body)
                    Text(message.date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                TextField("Enter your message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    viewModel.sendMessage(text: messageText)
                    messageText = ""
                }) {
                    Text("Send")
                }
            }
            .padding()
        }
        .navigationTitle(chat.targetnick ?? "Chat")
        .onAppear {
            viewModel.loadMessages()
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(chat: ChatList(id: UUID(), chat: "123", target: "Target", targetnick: "Target Nick"))
    }
}
