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

    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()

    var chatId: String
    private var offset: Int = 0
    private let limit: Int = 20

    init(chatId: String) {
        self.chatId = chatId
        loadMessages()
    }

    func loadMessages() {
        userService.getMessageList(chatId: chatId, offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .success(let messageListResponse):
                DispatchQueue.main.async {
                    guard let self = self else { return } // Asegúrate de que `self` no sea nil
                    let newMessages = messageListResponse.rows.filter { newMessage in
                        !self.messages.contains(where: { $0.id == newMessage.id })
                    }
                    self.messages.append(contentsOf: newMessages)
                    self.offset += newMessages.count
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    // Manejar el error aquí, si es necesario
                    print("Error loading messages: \(error.localizedDescription)")
                }
            }
        }
    }
}
