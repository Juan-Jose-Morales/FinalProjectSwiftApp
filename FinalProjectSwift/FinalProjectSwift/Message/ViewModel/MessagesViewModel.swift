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

    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?

    var chatId: String
    private var offset: Int = 0
    private let limit: Int = 20

    init(chatId: String) {
        self.chatId = chatId
        loadMessages()
        startTimer()
    }

    deinit {
        stopTimer()
    }

    func loadMessages() {
        userService.getMessageList(chatId: chatId, offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .success(let messageListResponse):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    let newMessages = messageListResponse.rows.filter { newMessage in
                        !self.messages.contains(where: { $0.id == newMessage.id })
                    }
                    self.messages.append(contentsOf: newMessages)
                    self.offset += newMessages.count
                    self.isRefreshingMessages = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error loading messages: \(error.localizedDescription)")
                }
            }
        }
    }

    func loadMoreMessages() {
        guard !isLoadingMoreMessages else { return }
        isLoadingMoreMessages = true

        userService.getMessageList(chatId: chatId, offset: offset, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingMoreMessages = false
            }
            switch result {
            case .success(let messageListResponse):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    let newMessages = messageListResponse.rows.filter { newMessage in
                        !self.messages.contains(where: { $0.id == newMessage.id })
                    }
                    self.messages.append(contentsOf: newMessages)
                    self.offset += newMessages.count
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error loading more messages: \(error.localizedDescription)")
                }
            }
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            self?.refreshMessages()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func refreshMessages() {
        guard !isRefreshingMessages else { return }
        isRefreshingMessages = true

        userService.getMessageList(chatId: chatId, offset: 0, limit: limit) { [weak self] result in
            switch result {
            case .success(let messageListResponse):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    let newMessages = messageListResponse.rows.filter { newMessage in
                        !self.messages.contains(where: { $0.id == newMessage.id })
                    }
                    if !newMessages.isEmpty {
                        self.messages = newMessages + self.messages
                    }
                    self.isRefreshingMessages = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error refreshing messages: \(error.localizedDescription)")
                }
            }
        }
    }
    func messageIdentifier(for message: Message, messageCount: Int) -> String {
            return "\(message.id)-\(messageCount)"
        }
}
