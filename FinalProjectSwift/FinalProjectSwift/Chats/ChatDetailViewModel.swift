//
//  ChatDetailViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 28/7/24.
//

import Foundation
import SwiftUI

class ChatDetailViewModel: ObservableObject {
    
    var name: String
    var id: String
    var color: Color
    var capitalizedName: String
    var chatId: String
    var chat: ChatList
    
    init(name: String, id: String, color: Color, capitalizedName: String, chatId: String, chat : ChatList){
        self.name = name
        self.id = id
        self.color = color
        self.capitalizedName = capitalizedName
        self.chatId = chatId
        self.chat = chat
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
}
