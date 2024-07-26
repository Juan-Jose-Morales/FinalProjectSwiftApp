//
//  NewChatResponse.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 23/7/24.
//

import Foundation

struct NewChatResponse: Decodable {
    var success: Bool
    var created: Bool
    var chat: Chat
}
