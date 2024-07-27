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

    @State private var scrollOffset: CGPoint = .zero

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
                .background(GeometryReader { geo in
                    Color.clear.preference(key: ViewOffsetKey.self, value: geo.frame(in: .global).origin)
                })
                .onPreferenceChange(ViewOffsetKey.self) { value in
                    self.scrollOffset = value
                    if value.y < 50 {
                        messagesViewModel.loadMoreMessages()
                    }
                }
                .onAppear {
                    if messagesViewModel.messages.isEmpty {
                        messagesViewModel.loadMessages()
                    }
                }
                .onChange(of: messagesViewModel.messages.count) { _ in
                    // Restaurar la posición del scroll
                    DispatchQueue.main.async {
                        scrollViewProxy.scrollTo(messagesViewModel.messages.last?.id, anchor: .bottom)
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
