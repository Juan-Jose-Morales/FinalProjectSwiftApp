//
//  ChatService.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import Alamofire

class ChatService: ChatServiceProtocol {
    private let baseURL = "https://mock-movilidad.vass.es/chatvass/api"
    private let networkClient: NetworkClientProtocol
    var chatResponse: NewChatResponse?
    
    init(networkClient: NetworkClientProtocol = AlamofireNetworkClient()) {
        self.networkClient = networkClient
    }

    func getViewMessages(completion: @escaping (Result<[GetMessage], Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        networkClient.request("\(baseURL)/messages/view", method: .get, parameters: nil, headers: headers, completion: { (response: Result<[GetMessage], AFError>) in
            switch response {
            case .success(let messages):
                completion(.success(messages))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMessages(completion: @escaping (Result<[Message], Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        networkClient.request("\(baseURL)/messages", method: .get, parameters: nil, headers: headers, completion: { (response: Result<[Message], AFError>) in
            switch response {
            case .success(let messages):
                completion(.success(messages))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getMessageList(chatId: String, offset: Int, limit: Int, completion: @escaping (Result<MessageListResponse, AFError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        let url = "\(baseURL)/messages/list/\(chatId)?offset=\(offset)&limit=\(limit)"
        networkClient.request(url, method: .get, parameters: nil, headers: headers, completion: completion)
    }

    func sendMessage(chatId: String, message: String, completion: @escaping (Result<SendMessageResponse, AFError>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            completion(.failure(AFError.explicitlyCancelled))
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        let source = UserDefaults.standard.string(forKey: "id") ?? ""
        let parameters: [String: Any] = [
            "chat": chatId,
            "source": source,
            "message": message
        ]
        networkClient.request("\(baseURL)/messages/new", method: .post, parameters: parameters, headers: headers, completion: completion)
    }

    func getChatList(completion: @escaping (_ chatList: [ChatList]) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        networkClient.request("\(baseURL)/chats/view", method: .get, parameters: nil, headers: headers, completion: { (response: Result<[ChatList], AFError>) in
            switch response {
            case .success(let chatList):
                completion(chatList)
            case .failure:
                completion([])
            }
        })
    }

    func deleteChat(id: String) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        let url = "\(baseURL)/chats/\(id)"
        networkClient.request(url, method: .delete, parameters: nil, headers: headers, completion: { (response: Result<User, AFError>) in
           
        })
    }

    func getNewChat(completion: @escaping (_ newChatList: [NewChat]) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
            print("Error: Missing AuthToken")
            return
        }
        let headers: HTTPHeaders = ["Authorization": token]
        networkClient.request("\(baseURL)/users", method: .get, parameters: nil, headers: headers, completion: { (response: Result<[NewChat], AFError>) in
            switch response {
            case .success(let newChatList):
                completion(newChatList)
            case .failure:
                completion([])
            }
        })
    }

    func createChat(source: String, target: String) {
            guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
                print("Error: Missing AuthToken")
                return
            }
            let headers: HTTPHeaders = ["Authorization": token]
            let parameters: [String: Any] = ["source": source, "target": target]
            networkClient.request("\(baseURL)/chats", method: .post, parameters: parameters, headers: headers, completion: { (response: Result<NewChatResponse, AFError>) in
                switch response {
                case .success(let newChatResponse):
                    self.chatResponse = newChatResponse
                    print(newChatResponse)
                case .failure(let error):
                    print("Error creating chat: \(error)")
                
                }
            })
        }
}
