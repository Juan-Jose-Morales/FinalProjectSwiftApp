//
//  HomeViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 16/7/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var listChats: [ChatList] = []
    @Published var search = ""
    @Published var id = ""
    @Published var filterChats: [ChatList] = []
    @Published var profileImage: UIImage?
    @Published var user = User()
    
    
    private var userService = UserService()
    
    init(){
        getChatlist()
        loadProfileImage()
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
    private func loadProfileImage() {
            if let data = UserDefaults.standard.data(forKey: "profileImageKey"),
               let image = UIImage(data: data) {
                profileImage = image
            }
        }
    func fetchUserData() {
            userService.getUsers { result in
                switch result {
                case .success(let users):
                    if let user = users.first {
                        DispatchQueue.main.async {
                            self.user = user
                            self.loadProfileImage()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
    
    
}
