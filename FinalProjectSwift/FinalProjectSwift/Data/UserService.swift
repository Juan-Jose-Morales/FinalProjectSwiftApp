//
//  UserService.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 2/7/24.
//

import Foundation
import Alamofire

class UserService {
    
    private let baseUrl = "https://mock-movilidad.vass.es/chatvass/api"
    
    func register(user: User, completion: @escaping (Result<User, Error>) -> Void ) {
        
        let url = "\(baseUrl)/users/register"
        let parameters: [String: Any] = [
        
            "login": user.login,
            "password": user.password,
            "nick": user.nick,
            "avatar": user.avatar ?? "",
            "platform": user.uuid ?? "",
            "uuid": user.uuid ?? "",
            "online": user.online
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: User.self) { response in
                
                switch response.result{
                case.success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
