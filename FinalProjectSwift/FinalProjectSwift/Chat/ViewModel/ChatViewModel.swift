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

    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()

    var chatId: String
    var chatList: ChatList
    @Published var messages: [Message] = []

    init(chatId: String, chatList: ChatList) {
        self.chatId = chatId
        self.chatList = chatList
        self.source = UserDefaults.standard.string(forKey: "id") ?? ""
    }

    func loadMessages() {
        userService.getMessageList(chatId: chatId, offset: 0, limit: 20) { [weak self] result in
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
        guard !messageText.isEmpty else {
            print("sendMessage: messageText is empty")
            return
        }

        print("sendMessage: Sending message...")
        source = UserDefaults.standard.string(forKey: "id") ?? ""

        userService.sendMessage(chatId: chatId, message: messageText) { [weak self] result in
            switch result {
            case .success(let sendMessageResponse):
                print("sendMessage: Success response received")
                if sendMessageResponse.success {
                    DispatchQueue.main.async {
                        print("sendMessage: Message successfully sent")
                        let newMessage = Message(id: UUID().uuidString, chat: self?.chatId ?? "", source: self?.source ?? "", message: self?.messageText ?? "", date: ISO8601DateFormatter().string(from: Date()))
                        self?.messages.insert(newMessage, at: 0)
                        self?.messageText = ""
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.errorMessage = "Error sending message: Failed to send message."
                        print("sendMessage: Failed to send message")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Error sending message: \(error.localizedDescription)"
                    print("sendMessage: Error sending message: \(error.localizedDescription)")
                }
            }
        }
    }

    func attachFile() {
        // Implementación de adjuntar archivo
    }
}
