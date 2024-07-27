//
//  ChatViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 18/7/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messageText: String = ""
    @Published var source: String = ""
    @Published var errorMessage: String?
    @Published var messages: [Message] = []
    @Published var isRefreshing: Bool = false

    private let chatService: ChatServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    var chatId: String
    var chatList: ChatList

    init(chatId: String, chatList: ChatList, chatService: ChatServiceProtocol = ChatService()) {
        self.chatId = chatId
        self.chatList = chatList
        self.chatService = chatService
        self.source = UserDefaults.standard.string(forKey: "id") ?? ""
        loadMessages()
    }

    func loadMessages() {
        chatService.getMessageList(chatId: chatId, offset: 0, limit: 20) { [weak self] result in
            switch result {
            case .success(let messageListResponse):
                DispatchQueue.main.async {
                    self?.messages = messageListResponse.rows
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Error loading messages: \(error.localizedDescription)"
                }
            }
        }
    }

    func sendMessage() {
        guard !messageText.isEmpty else { return }
        source = UserDefaults.standard.string(forKey: "id") ?? ""
        let newMessage = Message(id: UUID().uuidString, chat: chatId, source: source, message: messageText, date: ISO8601DateFormatter().string(from: Date()))

        chatService.sendMessage(chatId: chatId, message: messageText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sendMessageResponse):
                    if sendMessageResponse.success {
                        self?.messages.insert(newMessage, at: 0)
                        self?.messageText = ""
                    } else {
                        self?.errorMessage = "Error sending message: Failed to send message."
                    }
                case .failure(let error):
                    self?.errorMessage = "Error sending message: \(error.localizedDescription)"
                }
            }
        }
    }

    func attachFile() {
        
    }
}
