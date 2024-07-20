//
//  ChatView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 18/7/24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatViewModel: ChatViewModel
    
    var body: some View {
        VStack {
            ChatHeaderView(user: chatViewModel.user, profileImage: chatViewModel.changeProfileViewModel.profileImage)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(chatViewModel.messages, id: \.self) { message in
                        Text(message)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.top, 5)
                    }
                }
            }
            .padding(.top)
            
            ChatInputView(messageText: $chatViewModel.messageText, sendAction: {
                chatViewModel.sendMessage()
            }, attachAction: {
                chatViewModel.attachFile()
            })
            
        }
        .background(Color.white)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview("ChatView Preview") {
    let user = User(id: "1", login: "Pepe", password: "password", nick: "Pepe", avatar: nil, platform: nil, uuid: nil, online: true, created: "2024-07-11", updated: "2024-07-11", token: nil)
    let chatViewModel = ChatViewModel(user: user)
    return ChatView(chatViewModel: chatViewModel)
}
