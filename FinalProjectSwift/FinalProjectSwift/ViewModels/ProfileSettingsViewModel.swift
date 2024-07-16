//
//  ProfileSettingsViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 16/7/24.
//

import Foundation
import Combine
import Alamofire

class ProfileSettingsViewModel: ObservableObject {
    @Published var user = User()
    var userService = UserService()
    
    var buttons: [ButtonInfo] {
        [
            ButtonInfo(title: "Ajustes de perfil", iconName: "ProfileSettings", action: {}),
            ButtonInfo(title: "Almacenamiento", iconName: "Storage", action: {}),ButtonInfo(title: "Ajustes de idioma", iconName: "LanguageSettings", action: {})
            
        ]
    }
    
    func fetchUserData() {
        userService.getUsers { result in
            switch result {
            case.success(let users):
                if let user = users.first {
                    DispatchQueue.main.async {
                        self.user = user
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
struct ButtonInfo: Identifiable {
    var id = UUID()
    var title: String
    var iconName: String
    var action: () -> Void
}
