//
//  LoginViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 4/7/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var isLoginSuccessful: Bool = false
    @Published var authToken: String?

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
                case .success(let userResponse):
                    self?.handleLoggedInUser(userResponse.user)
                case .failure(let error):
                    self?.errorMessage = "Error al iniciar sesión: \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }

    private func handleLoggedInUser(_ user: User) {
        if let token = user.token {
            self.authToken = token
            UserDefaults.standard.set(token, forKey: "AuthToken")
        }

        self.isLoginSuccessful = true
    }

    func resetAlerts() {
        self.errorMessage = nil
        self.showAlert = false
    }
}
