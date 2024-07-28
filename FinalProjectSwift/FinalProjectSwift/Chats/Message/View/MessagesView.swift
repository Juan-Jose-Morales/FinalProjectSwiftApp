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

    @State private var isScrolling = false

    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(alignment: .leading) {
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
                    .onAppear {
                        if let lastMessageId = messagesViewModel.messages.last?.id {
                            scrollViewProxy.scrollTo(lastMessageId, anchor: .bottom)
                        }
                        if messagesViewModel.messages.isEmpty {
                            messagesViewModel.loadMessages()
                        }
                    }
                    .onChange(of: messagesViewModel.messages.count) { _ in
                        DispatchQueue.main.async {
                            if !isScrolling {
                                if let lastMessageId = messagesViewModel.messages.last?.id {
                                    scrollViewProxy.scrollTo(lastMessageId, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
            }
            .overlay(
                VStack {
                    if messagesViewModel.isRefreshingMessages {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
                }
                .background(Color.white.opacity(0.8))
            )
        }
        .padding(.top)
        .background(Color.white)
        .gesture(
            DragGesture()
                .onChanged { _ in
                    isScrolling = true
                }
                .onEnded { _ in
                    isScrolling = false
                }
        )
    }
}
