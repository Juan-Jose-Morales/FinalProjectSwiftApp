//
//  ChatViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 18/7/24.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var errorMessage: String?
    @Published var messageText: String = ""

    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()

    var chatId: String
    var chatList: ChatList
    private var offset: Int = 0
    private let limit: Int = 20

    init(chatId: String, chatList: ChatList) {
        self.chatId = chatId
        self.chatList = chatList
        loadMessages()
    }

    func loadMessages() {
        userService.getMessageList(chatId: chatId, offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .success(let messageListResponse):
                DispatchQueue.main.async {
                    self?.messages.append(contentsOf: messageListResponse.rows)
                    self?.offset += messageListResponse.rows.count
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

        userService.sendMessage(text: messageText, to: chatId) { [weak self] result in
            switch result {
            case .success(let sendMessageResponse):
                if sendMessageResponse.success {
                    self?.messageText = ""
                    self?.offset = 0
                    self?.messages.removeAll()
                    self?.loadMessages()
                } else {
                    DispatchQueue.main.async {
                        self?.errorMessage = "Error sending message: Failed to send message."
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Error sending message: \(error.localizedDescription)"
                }
            }
        }
    }

    private func getCurrentDateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: Date())
    }

    func attachFile() {
    
    }
    
  

}
