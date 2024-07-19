//
//  HomeViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 16/7/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var listChats: [ChatList] = []
    @Published var search = ""
    @Published var id = ""
    
    private var userService = UserService()
    
    init(){
        getChatlist()
    }
    
    
    func getChatlist(){
        userService.getChatList { chatList in
            self.listChats = chatList
        }
    }
    func deleteChat(id: String){
        userService.deletechat(id: id)
    }
}
