//
//  UserService.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 2/7/24.
//

import Foundation
import Alamofire

class UserService {
    private let baseURL = "https://mock-movilidad.vass.es/chatvass/api"
    let USER_EXISTENCE_STATUS_CODE = 409
    
    func login(username: String, password: String, completion: @escaping (Result<UserResponse, AFError>) -> Void) {
        let parameters: [String: Any] = [
            "password": password,
            "login": username
        ]
        
        AF.request("\(baseURL)/users/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: UserResponse.self) { response in
                completion(response.result)
            }
    }
    
    func register(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        let url = "\(baseURL)/users/register"
        let parameters: [String: Any] = [
            "login": user.login,
            "password": user.password,
            "nick": user.nick ?? "",
            "avatar": user.avatar ?? "",
            "platform": user.platform ?? "",
            "uuid": user.uuid ?? UUID().uuidString,
            "online": user.online ?? false
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: UserResponse.self) { response in
                if let data = response.data {
                    print("Datos del servidor: \(String(data: data, encoding: .utf8) ?? "No se pudo decodificar los datos")")
                }
                
                switch response.result {
                case .success(let userResponse):
                    completion(.success(userResponse.user))
                case .failure(let error):
                    if let statusCode = response.response?.statusCode,
                       statusCode == self.USER_EXISTENCE_STATUS_CODE {
                        completion(.failure(NSError(domain: "UserAlreadyExists", code: 1, userInfo: ["message": "El usuario ya existe"])))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = "\(baseURL)/users"
        
        AF.request(url, method: .get)
            .responseDecodable(of: [User].self) { response in
                switch response.result {
                case .success(let users):
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
    struct UserResponse: Codable {
        let success: Bool
        let user: User
    }
