//
//  ProfileViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 16/7/24.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var userName: String = "Usuario"
    @Published var profileImage: UIImage?
    @Published var isLoading: Bool = false
    
    private let userService: UserService
    private let profileImageKey = "profileImageKey"
    
    init(userService: UserService) {
        self.userService = userService
        fetchUserName()
        fetchProfilePhoto()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchUserName), name: UserDefaults.didChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchProfilePhoto), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    @objc func fetchUserName(){
        isLoading = true
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        let userNick = UserDefaults.standard.string(forKey: "userNick") ?? username
        
        DispatchQueue.main.async {
            self.isLoading = false
            self.userName = userNick.isEmpty ? "Usuario" : userNick
        }
    }
    
    @objc func fetchProfilePhoto() {
        if let imageData = UserDefaults.standard.data(forKey: profileImageKey),
           let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.profileImage = image
            }
        }
    }
    
    func saveUserName() {
        UserDefaults.standard.set(userName, forKey: "userNick")
    }
}



