//
//  Chat.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 23/7/24.
//

import Foundation

struct Chat: Identifiable, Decodable {
    let id: String
    let source: String
    let target: String
    let created: String

    enum CodingKeys: CodingKey {
        case id
        case source
        case target
        case created
    }
}
