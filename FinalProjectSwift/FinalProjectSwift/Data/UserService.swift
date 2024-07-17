//
//  UserService.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 2/7/24.
//

import Foundation
import Alamofire

class UserService {
    private var session: Session
    private let baseURL = "https://mock-movilidad.vass.es/chatvass/api"
    let USER_EXISTENCE_STATUS_CODE = 409
    
    init() {
        let interceptor = AuthInterceptor()
            session = Session(interceptor: interceptor)
        }
    
    func login(username: String, password: String, completion: @escaping (Result<(String, User), AFError>) -> Void) {
        let parameters: [String: Any] = [
            "password": password,
            "login": username
        ]
        
        AF.request("\(baseURL)/users/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: LoginUserResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    UserDefaults.standard.set(loginResponse.token, forKey: "AuthToken")
                    completion(.success((loginResponse.token, loginResponse.user)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func loginWithBiometrics(completion: @escaping (Result<(String, User), AFError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        
        print("Using token: \(token)")
        
        let headers: HTTPHeaders = ["Authorization": token]
        
        AF.request("\(baseURL)/users/biometric", method: .post, headers: headers)
            .responseDecodable(of: LoginUserResponse.self) { response in
                print("Response status code: \(String(describing: response.response?.statusCode))")
                if let data = response.data {
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "No se pudo decodificar los datos")")
                }
                
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(AFError.responseSerializationFailed(reason: .inputFileNil)))
                    return
                }
                
                switch statusCode {
                case 200:
                    guard let loginResponse = response.value else {
                        completion(.failure(AFError.responseSerializationFailed(reason: .inputFileNil)))
                        return
                    }
                    UserDefaults.standard.set(loginResponse.token, forKey: "AuthToken")
                    completion(.success((loginResponse.token, loginResponse.user)))
                default:
                    if let data = response.data {
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            print("Error message: \(errorResponse.message)")
                        } catch {
                            print("Error decoding error response: \(error)")
                        }
                    }
                    completion(.failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: statusCode))))
                }
            }
    }
    
    
    
    
    
    func register(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        let url = "\(baseURL)/users/register"
        let parameters: [String: Any] = [
            "login": user.login ?? "",
            "password": user.password ?? "",
            "nick": user.nick ?? "",
            "avatar": user.avatar ?? "",
            "platform": user.platform ?? "",
            "uuid": user.uuid ?? UUID().uuidString,
            "online": user.online ?? false
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: UserResponse.self) { response in
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
    func getChatList(){
        
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": token]
        
        AF.request("\(baseURL)/chats/view/", encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: [ChatList].self) {
                response in
                switch response.result {
                            case .success(let data):
                                  print(data)
                              case .failure(let error):
                                 print(error)
                }
            }
    }
    func deletechat(id: String){
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": token]
        
        let parameters: [String: Any] = [
            "id": "\(id)"
        ]
        AF.request("\(baseURL)/chats/\(id)", method: .delete, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
