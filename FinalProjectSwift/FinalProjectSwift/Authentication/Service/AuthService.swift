//
//  AuthService.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import Alamofire


class AuthService: AuthServiceProtocol {
    private let baseURL = "https://mock-movilidad.vass.es/chatvass/api"
    private let userDefaults: UserDefaults
    private let networkClient: NetworkClientProtocol

    init(userDefaults: UserDefaults = .standard, networkClient: NetworkClientProtocol = AlamofireNetworkClient()) {
        self.userDefaults = userDefaults
        self.networkClient = networkClient
    }

    func login(username: String, password: String, completion: @escaping (Result<(String, User), AFError>) -> Void) {
        let parameters: [String: Any] = ["password": password, "login": username]
        networkClient.request("\(baseURL)/users/login", method: .post, parameters: parameters, headers: nil, completion: { (response: Result<LoginUserResponse, AFError>) in
            switch response {
            case .success(let loginResponse):
                self.userDefaults.set(loginResponse.token, forKey: "AuthToken")
                self.userDefaults.set(loginResponse.user.id, forKey: "id")
                completion(.success((loginResponse.token, loginResponse.user)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func loginWithBiometrics(completion: @escaping (Result<(String, User), AFError>) -> Void) {
        guard let token = userDefaults.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        networkClient.request("\(baseURL)/users/biometric", method: .post, parameters: nil, headers: headers, completion: { (response: Result<LoginUserResponse, AFError>) in
            switch response {
            case .success(let loginResponse):
                self.userDefaults.set(loginResponse.token, forKey: "AuthToken")
                completion(.success((loginResponse.token, loginResponse.user)))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func logout(completion: @escaping (Result<Void, AFError>) -> Void) {
        guard let token = userDefaults.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        networkClient.request("\(baseURL)/users/logout", method: .post, parameters: nil, headers: headers, completion: { (response: Result<LogoutResponse, AFError>) in
            switch response {
            case .success:
                self.userDefaults.removeObject(forKey: "AuthToken")
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
