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

    var messagesViewModel: MessagesViewModel

    private let chatService: ChatServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    var chatId: String
    var chatList: ChatList

    init(chatId: String, chatList: ChatList, chatService: ChatServiceProtocol = ChatService()) {
        self.chatId = chatId
        self.chatList = chatList
        self.chatService = chatService
        self.source = UserDefaults.standard.string(forKey: "id") ?? ""
        self.messagesViewModel = MessagesViewModel(chatService: chatService, chatId: chatId)
    }

    func sendMessage() {
        guard !messageText.isEmpty else { return }
        source = UserDefaults.standard.string(forKey: "id") ?? ""

        chatService.sendMessage(chatId: chatId, message: messageText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sendMessageResponse):
                    if sendMessageResponse.success {
                        self?.messagesViewModel.loadMessages()
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
}
