//
//  MessageViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 22/7/24.
//

import Foundation
import Combine

class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var errorMessage: String?
    
    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()
    
    let chatId: String
    
    init(chatId: String) {
        self.chatId = chatId
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
    
    func sendMessage(text: String) {
        userService.sendMessage(text: text, to: chatId) { [weak self] result in
            switch result {
            case .success(let sendMessageResponse):
                if sendMessageResponse.success {
                    self?.loadMessages()  // Recarga los mensajes después de enviar uno nuevo
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
}
