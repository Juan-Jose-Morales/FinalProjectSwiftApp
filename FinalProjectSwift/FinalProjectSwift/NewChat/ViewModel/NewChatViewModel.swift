//
//  NewChatViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 23/7/24.
//

import Foundation
import SwiftUI

class NewChatViewModel: ObservableObject{
    @Published var newListChats: [NewChat] = []
    @Published var scrollLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @Published var showAlert = false
    @Published var alertNewChat: NewChat?
    @Published var chatFilter: [NewChat] = []
    @Published var search = "" {
        didSet {
            getChatFilter()
        }
    }
    
    
    private var userService = UserService()
    
    init(){
        getNewChats()
    }
    
    func getNewChats(){
        userService.getNewChat { newChatList in
            self.newListChats = newChatList
            self.chatFilter = newChatList
            self.chatFilter = self.newListChats.sorted {
                       ($0.nick ?? "").localizedCaseInsensitiveCompare($1.nick ?? "") == .orderedAscending
                   }
        }
    }
    func createdChat(target: String){
        
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return
        }
        userService.CreatedChat(source: id , target: target)
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
        if newUser.nick == ""{
            return "Usuario Desconocido \(newUser.id)"
        }else {
            return newUser.nick ?? "Usuario Desconocido"
        }
    }
    func capitalizedName(name: String) -> String {
        if name == ""{
            return "?"
        }else {
            return name.prefix(1).capitalized
        }
    }
    func excludeSelfChat(){
        
    }
    
}
