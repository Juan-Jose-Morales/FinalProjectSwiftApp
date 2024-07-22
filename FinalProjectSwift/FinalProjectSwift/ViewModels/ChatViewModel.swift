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
    
    init(chatId: String, chatList: ChatList) {
        self.chatId = chatId
        self.chatList = chatList
        loadMessages()
    }
    
    func loadMessages() {
        userService.getMessages(for: chatId) { [weak self] result in
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
        
        userService.sendMessage(text: messageText, to: chatId) { [weak self] result in
            switch result {
            case .success(let sendMessageResponse):
                if sendMessageResponse.success {
                    self?.loadMessages()
                    self?.messageText = "" // Clear message text after sending
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
    
    func attachFile() {
        // Implement file attachment logic here
    }
}
