//
//  NewChatViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 23/7/24.
//

import Foundation
import SwiftUI

class NewChatViewModel: ObservableObject {
    @Published var newListChats: [NewChat] = []
    @Published var scrollLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @Published var showAlert = false
    @Published var alertNewChat: NewChat?
    @Published var chatFilter: [NewChat] = []
    @Published var navigationChat = false
    @Published var search = "" {
        didSet {
            getChatFilter()
        }
    }
    @Published var response: NewChatResponse?
    private var colorManager = RandomColorManager.shared
    
    private var chatService: ChatServiceProtocol
    
    init(chatService: ChatServiceProtocol = ChatService()) {
        self.chatService = chatService
        getNewChats()
    }
    
    func getNewChats() {
        chatService.getNewChat { newChatList in
            self.newListChats = newChatList
            self.chatFilter = newChatList
        }
    }
    
    func createChat(target: String) {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return
        }
        chatService.createChat(source: id, target: target) { result in
            switch result {
            case .success(let success):
                self.navigationChat = true
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getChatFilter() {
        if search.isEmpty {
            chatFilter = newListChats.sorted {
                ($0.nick ?? "").localizedCaseInsensitiveCompare($1.nick ?? "") == .orderedAscending
            }
        } else {
            chatFilter = newListChats.filter { chat in
                chat.nick!.lowercased().contains(search.lowercased())
            }
        }
    }
    
    func convertToChatList(newChat: NewChat) -> ChatList {
        return ChatList(
            chat: newChat.id,
            source: newChat.id,
            sourceNick: newChat.nick,
            sourceonline: newChat.online,
            target: newChat.uuid,
            targetnick: newChat.login,
            targetonline: newChat.online,
            chatcreated: newChat.created
        )
    }
    
    func randomColor() -> Color {
        var red: Double
        var green: Double
        var blue: Double
        
        repeat {
            red = Double.random(in: 0...1)
            green = Double.random(in: 0...1)
            blue = Double.random(in: 0...1)
        } while (red > 0.9 && green > 0.9 && blue > 0.9)
        
        return Color(red: red, green: green, blue: blue)
    }
    
    func nameComprobation(newUser: NewChat) -> String {
        if newUser.nick == "" {
            return "Usuario Desconocido \(newUser.id)"
        } else {
            return newUser.nick ?? "Usuario Desconocido"
        }
    }
    
    func capitalizedName(name: String) -> String {
        if name == "" {
            return "?"
        } else {
            return name.prefix(1).capitalized
        }
    }
    
    func chatId() -> String? {
        return chatService.chatResponse?.chat.id
    }
    
    func checkSucces() -> Bool? {
        return chatService.chatResponse?.success
    }
    
    func color(for chatId: UUID) -> Color {
        return colorManager.color(for: chatId)
    }
}
