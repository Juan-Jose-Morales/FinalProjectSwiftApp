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
    @Published var source: String = ""

    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()

    var chatId: String
    var chatList: ChatList
    private var offset: Int = 0
    private let limit: Int = 20
    private var timer: Timer?

    init(chatId: String, chatList: ChatList) {
        self.chatId = chatId
        self.chatList = chatList
        loadMessages()
        self.source = UserDefaults.standard.string(forKey: "id") ?? ""
        startMessagePolling()
    }

    func loadMessages() {
           userService.getMessageList(chatId: chatId, offset: offset, limit: limit) { [weak self] result in
               switch result {
               case .success(let messageListResponse):
                   DispatchQueue.main.async {
                       let newMessages = messageListResponse.rows.filter { newMessage in
                           !self!.messages.contains(where: { $0.id == newMessage.id })
                       }
                       self?.messages.append(contentsOf: newMessages)
                       self?.offset += newMessages.count
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

    func getNick(chatList: ChatList) -> String {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return ""
        }

        return chatList.source == id ? chatList.targetnick! : chatList.sourceNick!
    }

    private func startMessagePolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.loadMessages()
        }
    }

    deinit {
        timer?.invalidate()
    }

    func attachFile() {
        
    }
}
