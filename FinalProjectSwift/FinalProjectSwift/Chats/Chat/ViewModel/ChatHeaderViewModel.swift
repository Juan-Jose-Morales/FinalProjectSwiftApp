//
//  ChatHeaderViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 25/7/24.
//

import Foundation
import SwiftUI

class ChatHeaderViewModel: ObservableObject {
    
    private var colorManager = RandomColorManager.shared
    
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
    func getName(chatList: ChatList) -> String {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return ""
        }
        
        return chatList.source == id ? chatList.targetnick! : chatList.sourceNick!
    }
}
