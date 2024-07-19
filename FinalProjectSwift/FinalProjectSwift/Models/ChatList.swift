//
//  ChatList.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 17/7/24.
//

import Foundation

struct ChatList: Identifiable ,Codable {
    var id = UUID()
    var chat: String?
    var source: String?
    var sourceonline: Bool?
    var target: String?
    var targetnick: String?
    var targetonline: Bool?
    var chatcreated: String?
    
    enum CodingKeys: CodingKey {
        case chat
        case source
        case sourceonline
        case target
        case targetnick
        case targetonline
        case chatcreated
    }
}
