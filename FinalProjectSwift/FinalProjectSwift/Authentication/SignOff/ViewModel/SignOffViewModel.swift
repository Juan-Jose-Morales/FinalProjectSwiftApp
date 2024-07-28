//
//  SignOffViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import Foundation
import Combine

class SignOffViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var isSignOffSuccessful: Bool = false
    
    private var authService: AuthServiceProtocol
    private var userService: UserService
    
    init(authService: AuthServiceProtocol = AuthService(), userService: UserService = UserService()) {
        self.authService = authService
        self.userService = userService
    }
    
    func signOff() {
        userService.updateOnlineStatus(isOnline: false) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.authService.logout { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success:
                                self?.isSignOffSuccessful = true
                            case .failure(let error):
                                self?.errorMessage = "Error al cerrar sesión \(error.localizedDescription)"
                                self?.showAlert = true
                            }
                        }
                    }
                case .failure(let error):
                    self?.errorMessage = "Error al actualizar estado en línea \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }
}
