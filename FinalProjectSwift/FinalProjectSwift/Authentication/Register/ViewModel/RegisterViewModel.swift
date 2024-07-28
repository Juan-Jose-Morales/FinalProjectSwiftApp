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
    @Published var avatar: String?
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var showSuccessAlert: Bool = false
    
    private var userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func register() {
        guard !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !nickname.isEmpty else {
            errorMessage = "Rellena todos los campos"
            showAlert = true
            return
        }
        
        guard password.trimmingCharacters(in: .whitespacesAndNewlines) == confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines) else {
            errorMessage = "Las contraseñas no coinciden"
            showAlert = true
            return
        }

        let user = User(login: username, password: password, nick: nickname, avatar: avatar, uuid: UUID().uuidString, online: true)
        
        userService.register(user: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Usuario registrado correctamente: \(user)")
                    self?.showSuccessAlert = true
                case .failure(let error):
                    print("Error al registrar usuario: \(error.localizedDescription)")
                    self?.errorMessage = "Error al registrar usuario: \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }
    
    func resetAlerts() {
        errorMessage = nil
        showAlert = false
        showSuccessAlert = false
    }
}
