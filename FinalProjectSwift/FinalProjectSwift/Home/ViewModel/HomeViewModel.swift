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
    @Published var search = "" {
        didSet {
            chatFilter()
        }
    }
    @Published var id = ""
    @Published var filterChats: [ChatList] = []
    @Published var profileImage: UIImage?
    @Published var user = User()
    @Published var color: Color?
    private var colorManager = RandomColorManager.shared
    
    
    
    private var userService = UserService()
    
    init() {
        getChatlist()
        loadProfileImage()
    }
    
    func getChatlist() {
        userService.getChatList { chatList in
            self.listChats = chatList
            self.filterChats = chatList
        }
    }
    func deleteChat(chatId: String) {
        userService.deletechat(id: chatId)
    }
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let chat = listChats[index]
            deleteChat(chatId: chat.chat)
        }
    }
    
    func chatFilter() {
        if search.isEmpty {
            filterChats = listChats
        } else {
            guard let id = UserDefaults.standard.string(forKey: "id") else {
                print("Error: Missing id")
                return
            }
            
            filterChats = listChats.filter { chat in
                chat.source == id ? chat.targetnick!.lowercased().contains(search.lowercased()) : chat.sourceNick!.lowercased().contains(search.lowercased())
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
    func getNick(chatList: ChatList) -> String {
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("Error: Missing id")
            return ""
        }
        
        return chatList.source == id ? chatList.targetnick! : chatList.sourceNick!
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
    func nameComprobation(user: ChatList) -> String {
        if getNick(chatList: user) == ""{
            return "Usuario Desconocido "
            // \(user.id)
        }else {
            return getNick(chatList: user)
        }
    }
    func capitalizedName(name: String) -> String {
        if name == ""{
            return "?"
        }else {
            return name.prefix(1).capitalized
        }
    }
    func color(for chatId: UUID) -> Color {
        return colorManager.color(for: chatId)
    }
}
