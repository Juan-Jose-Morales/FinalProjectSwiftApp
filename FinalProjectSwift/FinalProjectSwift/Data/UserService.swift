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
                    UserDefaults.standard.set(loginResponse.user.id, forKey: "id")
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
        
        let headers: HTTPHeaders = ["Authorization": token]
        
        AF.request("\(baseURL)/users/biometric", method: .post, headers: headers)
            .responseDecodable(of: LoginUserResponse.self) { response in
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
    func updateOnlineStatus(isOnline: Bool, completion: @escaping (Result<Void, AFError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        
        let url = "\(baseURL)/users/online/\(isOnline)"
        let headers: HTTPHeaders = ["Authorization": token]
        
        AF.request(url, method: .put, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
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
    func getMessages(for chatId: String, completion: @escaping (Result<MessageListResponse, Error>) -> Void) {
        let urlString = "\(baseURL)/chats/\(chatId)/messages"
        
        AF.request(urlString, method: .get)
            .validate()
            .responseDecodable(of: MessageListResponse.self) { response in
                switch response.result {
                case .success(let messageListResponse):
                    completion(.success(messageListResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    func getMessageList(chatId: String, offset: Int, limit: Int, completion: @escaping (Result<MessageListResponse, AFError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": token]
        let url = "\(baseURL)/messages/list/\(chatId)?offset=\(offset)&limit=\(limit)"
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: MessageListResponse.self) { response in
                completion(response.result)
            }
    }
    func sendMessage(chatId: String, message: String, completion: @escaping (Result<SendMessageResponse, AFError>) -> Void) {
      guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
        print("sendMessage: Error: Missing AuthToken")
        completion(.failure(AFError.explicitlyCancelled))
        return
      }

      print("sendMessage: AuthToken found")

      let headers: HTTPHeaders = ["Authorization": token]

      let source = UserDefaults.standard.string(forKey: "id") ?? ""

      let parameters = SendMessageRequest(chat: chatId, source: source, message: message)

      print("sendMessage: Sending request with parameters: \(parameters)")

      AF.request("\(baseURL)/messages/new", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
        .responseDecodable(of: SendMessageResponse.self) { response in
          switch response.result {
          case .success(let value):
            print("sendMessage: Response received - success: \(value.success)")
          case .failure(let error):
            print("sendMessage: Error received: \(error.localizedDescription)")
          }
          completion(response.result)
        }
    }
    func uploadProfilePhoto(userId: String, imageData: Data, completion: @escaping (Result<User, Error>) -> Void) {
        let url = "\(baseURL)/users/upload?id=\(userId)"
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": token]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file", fileName: "profile.jpg", mimeType: "image/jpeg")
        }, to: url, headers: headers).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func logout(completion: @escaping (Result<Void, AFError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }

        let headers: HTTPHeaders = ["Authorization": token]
        AF.request("\(baseURL)/users/logout", method: .post, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("Logout response data: \(String(data: data, encoding: .utf8) ?? "No Data")")
                    do {
                        let logoutResponse = try JSONDecoder().decode(LogoutResponse.self, from: data)
                        print("Logout message: \(logoutResponse.message)")
                        UserDefaults.standard.removeObject(forKey: "AuthToken")
                        completion(.success(()))
                    } catch {
                        print("Failed to decode logout response: \(error.localizedDescription)")
                        completion(.failure(AFError.responseSerializationFailed(reason: .inputFileNil)))
                    }
                case .failure(let error):
                    print("Logout error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    func getChatList(completion: @escaping (_ chatList: [ChatList]) -> Void){
        
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
                    completion(data)
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
        
        let headers: HTTPHeaders = ["Authorization": token ]
        
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
    func getNewChat(completion: @escaping (_ newcChatList: [NewChat]) -> Void){
        
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": token]
        
        AF.request("\(baseURL)/users", encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: [NewChat].self) {
                response in
                switch response.result {
                            case .success(let data):
                                  completion(data)
                              case .failure(let error):
                                 print(error)
                }
            }
    }
    func CreatedChat(source: String,target: String, completion: NewChatResponse?) {
        
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": token]
        
        let url = "\(baseURL)/chats"
        let parameters: [String: Any] = [
            "source": source,
            "target": target
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: NewChatResponse.self) { response in
                switch response.result {
                case .success(let completion):
                    print(completion)
                case .failure(let error):
                   print(error)
                }
            }
    }
}

