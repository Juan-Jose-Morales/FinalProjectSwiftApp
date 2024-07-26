//
//  MessagesView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 24/7/24.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject var messagesViewModel: MessagesViewModel
    var chatCreated: String

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                VStack(alignment: .leading) {
                    Text(formatChatCreationDate(chatCreated))
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ForEach(messagesViewModel.messages.reversed(), id: \.id) { message in
                        MessageView(
                            message: message,
                            isCurrentUser: message.source == UserDefaults.standard.string(forKey: "id")
                        )
                        .id(message.id)
                    }
                }
                .onChange(of: messagesViewModel.messages.count) { _ in
                    if let lastMessageId = messagesViewModel.messages.last?.id {
                        withAnimation{
                            scrollViewProxy.scrollTo(lastMessageId, anchor: .bottom)
                        }
                    }
                }
                .onAppear {
                    if messagesViewModel.messages.isEmpty {
                        messagesViewModel.loadMessages()
                    }
                }
                .onReachBottom {
                    if !messagesViewModel.isLoadingMoreMessages {
                        messagesViewModel.isLoadingMoreMessages = true
                        messagesViewModel.loadMessages()
                        messagesViewModel.isLoadingMoreMessages = false
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
        messagesViewModel: MessagesViewModel(chatId: "1"),
        chatCreated: "2024-07-22T16:03:44.798Z"
    )
}
