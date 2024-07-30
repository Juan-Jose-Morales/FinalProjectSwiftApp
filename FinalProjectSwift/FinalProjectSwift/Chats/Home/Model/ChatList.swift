//
//  ChatList.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 17/7/24.
//

import Foundation

struct ChatList: Identifiable ,Codable, Hashable {
    var id = UUID()
    var chat: String
    var source: String?
    var sourceNick: String?
    var sourceonline: Bool?
    var target: String?
    var targetnick: String?
    var targetonline: Bool?
    var chatcreated: String?
    
    enum CodingKeys: String, CodingKey {
        case chat
        case source
        case sourceNick = "sourcenick"
        case sourceonline
        case target
        case targetnick
        case targetonline
        case chatcreated
    }
}
