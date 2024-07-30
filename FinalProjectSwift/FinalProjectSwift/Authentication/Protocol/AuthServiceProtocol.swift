//
//  AuthServiceProtocol.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import Alamofire

protocol AuthServiceProtocol {
    func login(username: String, password: String, completion: @escaping (Result<(String, User), AFError>) -> Void)
    func loginWithBiometrics(completion: @escaping (Result<(String, User), AFError>) -> Void)
    func logout(completion: @escaping (Result<Void, AFError>) -> Void)
}
