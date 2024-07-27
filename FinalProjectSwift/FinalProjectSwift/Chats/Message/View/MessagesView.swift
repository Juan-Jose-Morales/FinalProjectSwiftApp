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
                }
                .background(GeometryReader { geo in
                    Color.clear.preference(key: ViewOffsetKey.self, value: geo.frame(in: .global).origin)
                })
                .onPreferenceChange(ViewOffsetKey.self) { value in
                    if !isScrolling {
                        self.scrollOffset = value
                        if value.y < 50 {
                            messagesViewModel.loadMessages()
                        }
                    }
                }
                .onAppear {
                    if messagesViewModel.messages.isEmpty {
                        messagesViewModel.loadMessages()
                    }
                }
                .onChange(of: messagesViewModel.messages.count) { _ in
                    DispatchQueue.main.async {
                        if !isScrolling {
                            scrollViewProxy.scrollTo(messagesViewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }
        }
        .padding(.top)
        .background(Color.white)
        .onReceive(messagesViewModel.$isRefreshingMessages) { isRefreshing in
            if !isRefreshing {
                isScrolling = false
            }
        }
        .gesture(
            DragGesture()
                .onChanged { _ in
                    isScrolling = true
                }
        )
    }
}

