//
//  ProfileSettingsViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 16/7/24.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class ProfileSettingsViewModel: ObservableObject {
    @Published var user = User()
    @Published var profileImage: UIImage?
    @Published var navigateToProfile = false
    
    var userService = UserService()
    
    var buttons: [ButtonInfo] {
        [
            ButtonInfo(title: "Ajustes de perfil", iconName: "ProfileSettings"){
                self.navigateToProfile = true
            },
            ButtonInfo(title: "Almacenamiento", iconName: "Storage", action: {}),ButtonInfo(title: "Ajustes de idioma", iconName: "LanguageSettings", action: {})
            
        ]
    }
    init() {
          loadUserNick()
        loadProfileImage()
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
    
    private func loadProfileImage() {
            if let data = UserDefaults.standard.data(forKey: "profileImageKey"),
               let image = UIImage(data: data) {
                profileImage = image
            }
        }

    
    private func loadUserNick() {
            if let userNick = UserDefaults.standard.string(forKey: "userNick") {
                user.nick = userNick
            } else {
                user.nick = "Usuario"
            }
        }
}

struct ButtonInfo: Identifiable {
    var id = UUID()
    var title: String
    var iconName: String
    var action: () -> Void
}
