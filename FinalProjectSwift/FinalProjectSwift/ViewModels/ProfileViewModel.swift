//
//  ProfileViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 16/7/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var userName: String = "Usuario"
    @Published var isLoading: Bool = false
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
        fetchUserName()
    }
    
    func fetchUserName(){
        isLoading = true
        
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let userNick = UserDefaults.standard.string(forKey: "userNick") ?? username
        
        DispatchQueue.main.async {
            self.isLoading = false
            self.userName = userNick.isEmpty ? "Usuario" : userNick
        }
    }
    func saveUserName() {
        UserDefaults.standard.set(userName, forKey: "userNick")
    }
    
}


