//
//  SignOffViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import Foundation
import Combine
import Alamofire

class SignOffViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var isSignOffSucessful: Bool = false
    
    private var userService: UserService
        
    init(userService: UserService = UserService()) {
            self.userService = userService
        }
    
    func signOff() {
        userService.logout { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.isSignOffSucessful = true
                case .failure(let error):
                    self?.errorMessage = "Error al cerrar sesion \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
            
        }
    }
    
}
