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
        
        return chatList.source == id ? chatList.targetnick! : chatList.sourceNick!
    }
    func color(for chatId: UUID) -> Color {
        return colorManager.color(for: chatId)
    }
}
