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
    private var timer: Timer?

    var chatId: String
    var chatList: ChatList

    init(chatId: String, chatList: ChatList, chatService: ChatServiceProtocol = ChatService()) {
        self.chatId = chatId
        self.chatList = chatList
        self.chatService = chatService
        self.source = UserDefaults.standard.string(forKey: "id") ?? ""
        loadMessages()
        startListeningForMessages()
    }

    deinit {
        stopListeningForMessages()
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
        // Implement attach file functionality
    }

    func startListeningForMessages() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.fetchNewMessages()
        }
    }

    func stopListeningForMessages() {
        timer?.invalidate()
        timer = nil
    }

    private func fetchNewMessages() {
        guard !isRefreshing else { return }
        isRefreshing = true
        chatService.getMessageList(chatId: chatId, offset: 0, limit: 20) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let messageListResponse):
                    let newMessages = messageListResponse.rows.filter { newMessage in
                        !self.messages.contains(where: { $0.id == newMessage.id })
                    }
                    self.messages.append(contentsOf: newMessages)
                case .failure(let error):
                    self.errorMessage = "Error fetching new messages: \(error.localizedDescription)"
                }
                self.isRefreshing = false
            }
        }
    }
}
