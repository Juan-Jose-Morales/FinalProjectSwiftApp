//
//  MessagesView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 24/7/24.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var chatViewModel: ChatViewModel
    @Binding var isLoadingMoreMessages: Bool
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                VStack(alignment: .leading) {
                    Text(formatChatCreationDate(chatViewModel.chatList.chatcreated ?? ""))
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ForEach(chatViewModel.messages.reversed(), id: \.id) { message in
                        MessageView(message: message, chatViewModel: chatViewModel)
                            .id(message.id)
                    }
                }
                .onChange(of: chatViewModel.messages.count) { _ in
                    if let lastMessageId = chatViewModel.messages.last?.id {
                        scrollViewProxy.scrollTo(lastMessageId, anchor: .bottom)
                    }
                }
                .onAppear {
                    if chatViewModel.messages.isEmpty {
                        chatViewModel.loadMessages()
                    }
                }
                .onReachBottom {
                    if !isLoadingMoreMessages {
                        isLoadingMoreMessages = true
                        chatViewModel.loadMessages()
                        isLoadingMoreMessages = false
                    }
                }
            }
            .padding(.top)
            .background(Color.white)
        }
    }
}

#Preview {
    MessagesView(
        chatViewModel: ChatViewModel(chatId: "1", chatList: ChatList(chat: "1", source: "user1", chatcreated: "2024-07-22T16:03:44.798Z")),
        isLoadingMoreMessages: .constant(false)
    )
}
