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
            chatFilter = newListChats
        } else {
            
            chatFilter = newListChats.filter { chat in
                chat.nick!.lowercased().contains(search.lowercased())
            }
        }
    }
}
