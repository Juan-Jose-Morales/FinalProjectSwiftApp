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
    @Published var isOnline: Bool
    
    private let userService: UserService
    private let profileImageKey = "profileImageKey"
    private let onlineStatusKey = "onlineStatusKey"
    
    init(userService: UserService) {
        self.userService = userService
        self.isOnline = UserDefaults.standard.bool(forKey: onlineStatusKey) 
        if UserDefaults.standard.object(forKey: onlineStatusKey) == nil {
            UserDefaults.standard.set(true, forKey: onlineStatusKey)
            self.isOnline = true
        }
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
    
    func updateOnlineStatus(isOnline: Bool) {
        self.isLoading = true
        userService.updateOnlineStatus(isOnline: isOnline) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isOnline = isOnline
                    UserDefaults.standard.set(isOnline, forKey: "onlineStatusKey")
                case .failure(let error):
                    print("Error updating online status: \(error.localizedDescription)")
                }
            }
        }
    }
}
