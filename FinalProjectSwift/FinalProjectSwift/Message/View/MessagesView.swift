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
    
    // Estado para controlar si estamos en el fondo del scroll
    @State private var isAtBottom = true
    
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
                        .id(messagesViewModel.messageIdentifier(for: message, messageCount: messagesViewModel.messages.count))
                    }
                }
                .onChange(of: messagesViewModel.messages.count) { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo(messagesViewModel.messages.last?.id, anchor: .bottom)
                    }
                }
                .onAppear {
                    if messagesViewModel.messages.isEmpty {
                        messagesViewModel.loadMessages()
                    }
                }
                .onReachBottom {
                    if !messagesViewModel.isLoadingMoreMessages {
                        messagesViewModel.loadMoreMessages()
                    }
                }
                .background(GeometryReader { geo in
                    Color.clear
                        .onChange(of: geo.frame(in: .global).maxY) { newValue in
                            let offset = geo.frame(in: .global).maxY - geo.size.height
                            isAtBottom = offset <= 50
                        }
                })
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
