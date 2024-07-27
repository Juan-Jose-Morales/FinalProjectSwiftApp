//
//  UserService.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 2/7/24.
//

import Foundation
import Alamofire

class UserService: UserServiceProtocol {
    private let baseURL = "https://mock-movilidad.vass.es/chatvass/api"
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = AlamofireNetworkClient()) {
        self.networkClient = networkClient
    }

    func register(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        let parameters: [String: Any] = [
            "login": user.login ?? "",
            "password": user.password ?? "",
            "nick": user.nick ?? "",
            "avatar": user.avatar ?? "",
            "platform": user.platform ?? "",
            "uuid": user.uuid ?? UUID().uuidString,
            "online": user.online ?? false
        ]
        networkClient.request("\(baseURL)/users/register", method: .post, parameters: parameters, headers: nil, completion: { (response: Result<UserResponse, AFError>) in
            switch response {
            case .success(let userResponse):
                completion(.success(userResponse.user))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func updateOnlineStatus(isOnline: Bool, completion: @escaping (Result<Void, AFError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        let url = "\(baseURL)/users/online/\(isOnline ? "true" : "false")"
        networkClient.request(url, method: .put, parameters: nil, headers: headers, completion: { (response: Result<OnlineStatusResponse, AFError>) in
            switch response {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
