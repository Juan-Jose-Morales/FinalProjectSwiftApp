//
//  HomeViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 16/7/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var listChats: [ChatList] = []
    @Published var search = "" {
        didSet {
            chatFilter()
        }
    }
    @Published var id = ""
    @Published var filterChats: [ChatList] = []
    @Published var profileImage: UIImage?
    @Published var user = User()
    @Published var color: Color?
    private var colorManager = RandomColorManager.shared
    
    private var chatService: ChatServiceProtocol
    
    init(chatService: ChatServiceProtocol = ChatService()) {
        self.chatService = chatService
        getChatlist()
        loadProfileImage()
    }
    
    func getChatlist() {
        chatService.getChatList { chatList in
            self.listChats = chatList
            self.filterChats = chatList
        }
    }
    
    func deleteChat(id: String) {
        chatService.deleteChat(id: id)
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let chat = filterChats[index]
            deleteChat(id: chat.chat)
            
            filterChats.remove(at: index)
            
            if let index = listChats.firstIndex(where: { $0.chat == chat.chat }) {
                        listChats.remove(at: index)
                    }
            
        }
    }
    
    func chatFilter() {
        if search.isEmpty {
            filterChats = listChats
        } else {
            guard let id = UserDefaults.standard.string(forKey: "id") else {
                print("Error: Missing id")
                return
            }
            
            filterChats = listChats.filter { chat in
                chat.source == id ? chat.targetnick!.lowercased().contains(search.lowercased()) : chat.sourceNick!.lowercased().contains(search.lowercased())
            }
        }
    }
    
    private func loadProfileImage() {
        if let data = UserDefaults.standard.data(forKey: "profileImageKey"),
           let image = UIImage(data: data) {
            profileImage = image
        }
    }
    
    func getNick(chatList: ChatList) -> String {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return ""
        }
        
        let nick = chatList.source == id ? chatList.targetnick! : chatList.sourceNick!
        let otherUserId = chatList.source == id ? chatList.target! : chatList.source!
        if nick == ""{
            return "Usuario Desconocido \(otherUserId)"
        }else {
            return nick
        }
        
    }
    
    
    func capitalizedName(chatList : ChatList) -> String {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return ""
        }
        
        let nick = chatList.source == id ? chatList.targetnick! : chatList.sourceNick!
        if nick == ""{
            return "?"
        }else {
            return nick.prefix(1).capitalized
        }
    }

    func color(for chatId: UUID) -> Color {
        return colorManager.color(for: chatId)
    }
}
