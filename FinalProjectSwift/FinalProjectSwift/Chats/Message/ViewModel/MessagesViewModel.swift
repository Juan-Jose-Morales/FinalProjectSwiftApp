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
    private let limit: Int = 20

    init(chatService: ChatServiceProtocol = ChatService(), chatId: String) {
        self.chatService = chatService
        self.chatId = chatId
        loadMessages()
        startRefreshingMessages()
    }

    func loadMessages() {
        guard !isLoadingMoreMessages else { return }
        isLoadingMoreMessages = true

        chatService.getMessageList(chatId: chatId, offset: offset, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingMoreMessages = false
                switch result {
                case .success(let messageListResponse):
                    guard let self = self else { return }
                    let newMessages = messageListResponse.rows.filter { newMessage in
                        !self.messages.contains(where: { $0.id == newMessage.id })
                    }
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

        chatService.getMessageList(chatId: chatId, offset: 0, limit: offset + limit) { [weak self] result in
            DispatchQueue.main.async {
                self?.isRefreshingMessages = false
                switch result {
                case .success(let messageListResponse):
                    guard let self = self else { return }
                    let newMessages = messageListResponse.rows.filter { newMessage in
                        !self.messages.contains(where: { $0.id == newMessage.id })
                    }
                    if !newMessages.isEmpty {
                        self.messages.insert(contentsOf: newMessages, at: 0)
                    }
                case .failure(let error):
                    print("Error refreshing messages: \(error.localizedDescription)")
                }
            }
        }
    }

    private func startRefreshingMessages() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.refreshMessages()
        }
    }

    deinit {
        timer?.invalidate()
    }
}
