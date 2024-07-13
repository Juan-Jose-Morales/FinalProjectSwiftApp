//
//  LoginViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 4/7/24.
//

import Foundation
import Combine
import LocalAuthentication

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var isLoginSuccessful: Bool = false
    @Published var authToken: String?
    @Published var user: User?
    
    private var userService: UserService
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    func login() {
        guard !username.isEmpty, !password.isEmpty else {
            self.errorMessage = "Rellena todos los campos"
            self.showAlert = true
            return
        }
        
        userService.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let (token, user)):
                    UserDefaults.standard.set(token, forKey: "AuthToken")
                    UserDefaults.standard.synchronize()
                    self?.handleLoggedInUser(user, token: token)
                case .failure(let error):
                    self?.errorMessage = "Error al iniciar sesión: \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }
    
    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Autenticate para iniciar sesión"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.loginWithBiometrics()
                    } else {
                        self.errorMessage = "Error de autenticación biométrica"
                        self.showAlert = true
                    }
                }
            }
        } else {
            self.errorMessage = "La autenticación no está disponible"
            self.showAlert = true
        }
    }
    
    func loginWithBiometrics() {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            self.errorMessage = "Error: Missing AuthToken"
            self.showAlert = true
            return
        }
        
        print("Token: \(token)")
        
        userService.loginWithBiometrics { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let (token, user)):
                    print("Login biométrico exitoso, usuario: \(user)")
                    self?.handleLoggedInUser(user, token: token)
                case .failure(let error):
                    self?.errorMessage = "Error al iniciar sesión: \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }
    
    
    
    
    private func handleLoggedInUser(_ user: User, token: String? = nil) {
        if let token = token ?? user.token {
            self.authToken = token
            UserDefaults.standard.set(token, forKey: "AuthToken")
            UserDefaults.standard.synchronize()
            self.user = user
            self.isLoginSuccessful = true
        } else {
            self.errorMessage = "Error: Token missing in response."
            self.showAlert = true
        }
    }
    
    
    
    func resetAlerts() {
        self.errorMessage = nil
        self.showAlert = false
    }
}
