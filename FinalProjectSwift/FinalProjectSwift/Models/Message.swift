//
//  Message.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 22/7/24.
//

import Foundation


struct Message: Identifiable, Decodable {
    let id: String
    let chat: String
    let source: String
    let message: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case id
        case chat
        case source
        case message
        case date
    }
}

