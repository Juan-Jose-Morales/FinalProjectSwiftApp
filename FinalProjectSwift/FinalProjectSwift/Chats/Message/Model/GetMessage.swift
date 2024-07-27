//
//  GetMessage.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 26/7/24.
//

import Foundation

struct GetMessage: Identifiable, Decodable {
    let id: String
    let chat: String
    let source: String
    let nick: String?
    let avatar: String?
    let message: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case id, chat, source, nick, avatar, message, date
    }
}
