//
//  NewChatViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 23/7/24.
//

import Foundation

class NewChatViewModel: ObservableObject{
    @Published var newListChats: [NewChat] = []
    @Published var search = ""
    @Published var scrollLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @Published var showAlert = false
    
    
    private var userService = UserService()
    
    init(){
        getNewChats()
    }
    
    func getNewChats(){
        userService.getNewChat { newChatList in
            self.newListChats = newChatList
        }
    }
    func createdChat(target: String){
        
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return
        }
        userService.CreatedChat(source: id , target: target)
    }
}
