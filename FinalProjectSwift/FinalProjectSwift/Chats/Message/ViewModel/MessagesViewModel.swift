//
//  MessagesViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 26/7/24.
//

import Foundation
import Combine

class MessagesViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoadingMoreMessages: Bool = false
    @Published var isRefreshingMessages: Bool = false

    private let chatService: ChatServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?

    var chatId: String
    private var offset: Int = 0
    private let limit: Int = 100

    init(chatService: ChatServiceProtocol = ChatService(), chatId: String) {
        self.chatService = chatService
        self.chatId = chatId
        loadMessages()
        startTimer()
    }

    deinit {
        stopTimer()
    }

    func loadMessages() {
        guard !isLoadingMoreMessages else { return }
        isLoadingMoreMessages = true
        chatService.getMessageList(chatId: chatId, offset: offset, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoadingMoreMessages = false
                switch result {
                case .success(let messageListResponse):
                    let newMessages = messageListResponse.rows
                    self.messages.append(contentsOf: newMessages)
                    self.offset += newMessages.count
                case .failure(let error):
                    print("Error loading messages: \(error.localizedDescription)")
                }
            }
        }
    }

    func refreshMessages() {
        guard !isRefreshingMessages else { return }
        isRefreshingMessages = true
        chatService.getMessageList(chatId: chatId, offset: 0, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let messageListResponse):
                    let newMessages = messageListResponse.rows
                    if !newMessages.isEmpty {
                        self.messages = newMessages + self.messages
                    }
                case .failure(let error):
                    print("Error refreshing messages: \(error.localizedDescription)")
                }
                self.isRefreshingMessages = false
            }
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.refreshMessages()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func messageIdentifier(for message: Message, messageCount: Int) -> String {
        return "\(message.id)-\(messageCount)"
    }
}
