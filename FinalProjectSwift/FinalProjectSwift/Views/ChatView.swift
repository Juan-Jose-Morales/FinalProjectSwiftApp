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
        VStack(spacing: 0) {
            
            ChatHeaderView(chatlist: chatViewModel.chatList)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(chatViewModel.messages, id: \.id) { message in
                        HStack {
                            if message.source == chatViewModel.chatList.source {
                                Spacer()
                                Text(message.message)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(22)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.horizontal)
                            } else {
                                Text(message.message)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(22)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                Spacer()
                            }
                        }
                        .padding(.top, 5)
                    }
                }
            }
            .padding(.top)
            .background(Color.white)
            
            Spacer()
            
            ChatInputView(
                messageText: $chatViewModel.messageText,
                sendAction: {
                    chatViewModel.sendMessage()
                },
                attachAction: {
                    chatViewModel.attachFile()
                }
            )
            .padding(.bottom, keyboardResponder.currentHeight)
            .background(Color.white)
            .animation(.easeOut(duration: 0.3), value: keyboardResponder.currentHeight)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.white)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

#Preview("ChatView Preview") {
    let chatList = ChatList(id: UUID(), chat: "123", source: "1", sourceonline: true, target: "2", targetnick: "Pepe", targetonline: true)
    let chatViewModel = ChatViewModel(chatId: "someChatId", chatList: chatList)
    return ChatView(chatViewModel: chatViewModel)
}
