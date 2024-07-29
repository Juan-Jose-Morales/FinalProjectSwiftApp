//
//  ChatHeaderViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 25/7/24.
//

import Foundation
import SwiftUI

class ChatHeaderViewModel: ObservableObject {
    @Published var isOnline: Bool = false
    
    private var colorManager = RandomColorManager.shared
    
    func getNick(chatList: ChatList) -> String {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return ""
        }
        
        let nick = chatList.source == id ? chatList.targetnick ?? "" : chatList.sourceNick ?? ""
        let otherUserId = chatList.source == id ? chatList.target ?? "" : chatList.source ?? ""
        if nick.isEmpty {
            return "Usuario Desconocido \(otherUserId)"
        } else {
            return nick
        }
    }
    
    func capitalizedName(chatList: ChatList) -> String {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return ""
        }
        
        let nick = chatList.source == id ? chatList.targetnick ?? "" : chatList.sourceNick ?? ""
        if nick.isEmpty {
            return "?"
        } else {
            return String(nick.prefix(1)).capitalized
        }
    }

    func color(for chatId: UUID) -> Color {
        return colorManager.color(for: chatId)
    }
    
    func getName(chatList: ChatList) -> String {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return ""
        }
        
        return chatList.source == id ? chatList.targetnick ?? "" : chatList.sourceNick ?? ""
    }

    func updateOnlineStatus(chatList: ChatList) {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return
        }
        
        if chatList.source == id {
            isOnline = chatList.targetonline ?? false
        } else {
            isOnline = chatList.sourceonline ?? false
        }
    }
}

