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
            ButtonInfo(title: "profile-settings-profile", iconName: "ProfileSettings"){
                self.navigateToProfile = true
            },
            ButtonInfo(title: "profile-storage", iconName: "Storage", action: {}),ButtonInfo(title: "profile-languages-settings", iconName: "LanguageSettings", action: {})
            
        ]
    }
    init() {
        loadUserNick()
        loadProfileImage()
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
    var title: LocalizedStringKey
    var iconName: String
    var action: () -> Void
}
