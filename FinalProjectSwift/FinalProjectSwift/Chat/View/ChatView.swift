//
//  ChatView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 18/7/24.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatViewModel: ChatViewModel
    @StateObject private var keyboardResponder = KeyboardResponder()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ChatHeaderView(chatlist: chatViewModel.chatList)
                
                MessagesView(
                    messagesViewModel: MessagesViewModel(chatId: chatViewModel.chatId),
                    chatCreated: chatViewModel.chatList.chatcreated ?? ""
                )
                
                Spacer()
                
                ChatInputView(
                    messageText: $chatViewModel.messageText,
                    sendAction: { chatViewModel.sendMessage() },
                    attachAction: { chatViewModel.attachFile() }
                )
                .padding(.bottom, keyboardResponder.currentHeight)
                .background(Color.white)
                .animation(.easeOut(duration: 0.3), value: keyboardResponder.currentHeight)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.white)
            .onAppear {
                chatViewModel.loadMessages()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
#Preview {
    ChatView(
        chatViewModel: ChatViewModel(chatId: "1", chatList: ChatList(chat: "1", source: "user1", chatcreated: "2024-07-22T16:03:44.798Z"))
    )
    .environment(\.colorScheme, .light)
    .previewLayout(.sizeThatFits)
}
