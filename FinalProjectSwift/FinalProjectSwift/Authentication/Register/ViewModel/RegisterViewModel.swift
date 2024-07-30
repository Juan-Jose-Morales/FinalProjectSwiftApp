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
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String? = nil
    @Published var alertTitle: String = ""
    @Published var isSuccess: Bool = false
    
    private var userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func register() {
        if self.username.isEmpty || self.password.isEmpty || self.confirmPassword.isEmpty || self.nickname.isEmpty {
            DispatchQueue.main.async {
                self.alertTitle = "Error"
                self.alertMessage = "Rellena todos los campos"
                self.showAlert = true
                self.isSuccess = false
                print("ShowAlert: \(self.showAlert), AlertMessage: \(self.alertMessage ?? "None")")
            }
            return
        }
        
        if self.password.trimmingCharacters(in: .whitespacesAndNewlines) != self.confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines) {
            DispatchQueue.main.async {
                self.alertTitle = "Error"
                self.alertMessage = "Las contraseñas no coinciden"
                self.showAlert = true
                self.isSuccess = false
                print("ShowAlert: \(self.showAlert), AlertMessage: \(self.alertMessage ?? "None")")
            }
            return
        }
        
        let user = User(login: self.username, password: self.password, nick: self.nickname, avatar: self.avatar, uuid: UUID().uuidString, online: true)
        
        self.userService.register(user: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Usuario registrado correctamente: \(user)")
                    self?.alertTitle = "Registro Exitoso"
                    self?.alertMessage = "El registro fue exitoso"
                    self?.isSuccess = true
                case .failure(let error):
                    print("Error al registrar usuario: \(error.localizedDescription)")
                    self?.alertTitle = "Error"
                    self?.alertMessage = "Error al registrar usuario: \(error.localizedDescription)"
                    self?.isSuccess = false
                }
                self?.showAlert = true
            }
        }
    }
    
    func resetAlerts() {
        DispatchQueue.main.async {
            print("Reseteando alertas")
            self.alertMessage = nil
            self.showAlert = false
        }
    }
}
