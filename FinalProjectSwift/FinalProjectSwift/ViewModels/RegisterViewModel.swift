//
//  RegisterViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 2/7/24.
//

import Foundation
import Combine


class RegisterViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var nickname: String = ""
    @Published var avatar: String = ""
    @Published var plataform: String = "iOS"
    @Published var uuid: String = UUID().uuidString
    @Published var online: Bool = true
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var showSuccessAlert: Bool = false
    
    private var userService: UserService
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserService = UserService()) {
           self.userService = userService
       }
    
    func register (){
        guard !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            self.errorMessage = "Rellena todos los campos"
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden"
            return
        }
        let user = User(id: nil, login: username, password: password, nick: nickname, avatar: avatar, uuid: uuid, token: nil, online: online, created: nil, updated: nil)
        
        userService.register(user: user){ [weak self] result in
            switch result {
            case .success(let user):
                print("Usuario registrado: \(user)")
                self?.showSuccessAlert = true
            case .failure(_):
                self?.errorMessage = "Error al registrar"
                self?.showAlert = true
            }
            
        }
    }
}
