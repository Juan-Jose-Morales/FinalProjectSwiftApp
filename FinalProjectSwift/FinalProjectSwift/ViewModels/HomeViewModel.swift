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
    @Published var filterChats: [ChatList] = []
    
    
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
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let chat = listChats[index]
            deleteChat(id: chat.chat)
        }
    }
    
    func chatFilter() {
            if search.isEmpty {
                filterChats = listChats
            } else {
                filterChats = listChats.filter { chat in
                    chat.targetnick!.lowercased().contains(search.lowercased())
                }
            }
        }
    
    
    
}
