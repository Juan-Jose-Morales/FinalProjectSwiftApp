//
//  ChatList.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 17/7/24.
//

import Foundation

struct ChatList: Codable {
    var chat: String?
    var source: String?
    var sourceonline: Bool?
    var target: String?
    var targetnick: String?
    var targetonline: Bool?
    var chatcreated: String?
}
