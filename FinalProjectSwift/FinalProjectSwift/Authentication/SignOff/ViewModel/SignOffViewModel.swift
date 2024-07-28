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
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    func signOff() {
        authService.logout { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    UserDefaults.standard.set(false, forKey: "onlineStatusKey")
                    self?.isSignOffSuccessful = true
                case .failure(let error):
                    self?.errorMessage = "Error al cerrar sesión \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }

}
