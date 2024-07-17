//
//  HomeViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 16/7/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var listChats = []
    @Published var search = ""
    @Published var id = ""
    
    private var userService = UserService()
    
    
    func getChatlist(){
        userService.getChatList()
    }
    func deleteChat(id: String){
        userService.deletechat(id: id)
    }
}
