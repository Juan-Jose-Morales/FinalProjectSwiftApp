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
    @State private var isLoadingMoreMessages = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ChatHeaderView(chatlist: chatViewModel.chatList)
                
                ScrollView {
                    ScrollViewReader { scrollViewProxy in
                        VStack(alignment: .leading) {
                            
                            Text(formatChatCreationDate(chatViewModel.chatList.chatcreated ?? ""))
                                .padding(.horizontal)
                                .foregroundColor(.gray)
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .center)
                            ForEach(chatViewModel.messages, id: \.id) { message in
                                VStack(alignment: .leading) {
                                    HStack {
                                        if message.source == chatViewModel.chatList.source {
                                            Spacer()
                                            VStack(alignment: .trailing) {
                                                Text(message.message)
                                                    .padding()
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(22)
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                    .padding(.horizontal)
                                                Text(getTime(from: message.date))
                                                    .font(.footnote)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal)
                                            }
                                        } else {
                                            VStack(alignment: .leading) {
                                                Text(message.message)
                                                    .padding()
                                                    .background(Color("Blue"))
                                                    .cornerRadius(22)
                                                    .foregroundColor(.white)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(.horizontal)
                                                Text(getTime(from: message.date))
                                                    .font(.footnote)
                                                    .foregroundColor(.gray)
                                                    .padding(.horizontal)
                                            }
                                            Spacer()
                                        }
                                    }
                                    .padding(.top, 5)
                                }
                            }
                        }
                        .onChange(of: chatViewModel.messages.count) { _ in
                            scrollViewProxy.scrollTo(chatViewModel.messages.last?.id, anchor: .bottom)
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
                }
                .padding(.top)
                .background(Color.white)
                Spacer()
                ChatInputView(messageText: $chatViewModel.messageText, sendAction: { chatViewModel.sendMessage() }, attachAction: { chatViewModel.attachFile() })
                    .padding(.bottom, keyboardResponder.currentHeight)
                    .background(Color.white)
                    .animation(.easeOut(duration: 0.3), value: keyboardResponder.currentHeight)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.white)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }

    private func formatChatCreationDate(_ dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateTime) {
            let dateFormatterOutput = DateFormatter()
            dateFormatterOutput.dateFormat = "dd/MM/yyyy"
            return dateFormatterOutput.string(from: date)
        }
        return ""
    }

    private func getTime(from dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateTime) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            return timeFormatter.string(from: date)
        }
        return ""
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = 0
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    func onReachBottom(perform action: @escaping () -> Void) -> some View {
        self.background(
            GeometryReader { proxy in
                Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: proxy.frame(in: .named("scroll")).maxY)
            }
        )
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { maxY in
            if maxY == UIScreen.main.bounds.height {
                action()
            }
        }
    }
}

#Preview {
    ChatView(chatViewModel: ChatViewModel(chatId: "1", chatList: ChatList(chat: "1", source: "user1", chatcreated: "2024-07-22T16:03:44.798Z") ))
}
