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

    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?

    var chatId: String
    var chatList: ChatList

    init(chatId: String, chatList: ChatList) {
        self.chatId = chatId
        self.chatList = chatList
        self.source = UserDefaults.standard.string(forKey: "id") ?? ""
        startListeningForMessages()
    }

    deinit {
        stopListeningForMessages()
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
        let currentMessageCount = messages.count
        userService.getMessageList(chatId: chatId, offset: currentMessageCount, limit: 20) { [weak self] result in
            switch result {
            case .success(let messageListResponse):
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    let newMessages = messageListResponse.rows.filter { newMessage in
                        !self.messages.contains(where: { $0.id == newMessage.id })
                    }
                    self.messages.append(contentsOf: newMessages)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Error fetching new messages: \(error.localizedDescription)"
                }
            }
        }
    }
}
