//
//  ChatServiceProtocol.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import Alamofire

protocol ChatServiceProtocol {
    func getViewMessages(completion: @escaping (Result<[GetMessage], Error>) -> Void)
    func getMessages(completion: @escaping (Result<[Message], Error>) -> Void)
    func getMessageList(chatId: String, offset: Int, limit: Int, completion: @escaping (Result<MessageListResponse, AFError>) -> Void)
    func sendMessage(chatId: String, message: String, completion: @escaping (Result<SendMessageResponse, AFError>) -> Void)
    func getChatList(completion: @escaping (_ chatList: [ChatList]) -> Void)
    func deleteChat(id: String)
    func getNewChat(completion: @escaping (_ newChatList: [NewChat]) -> Void)
    func createChat(source: String, target: String)
}

