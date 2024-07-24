//
//  NewChat.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 23/7/24.
//

import Foundation

struct NewChat: Identifiable, Codable{
    var id: String
    var login: String?
    var nick: String?
    var avatar: String?
    var platform: String?
    var uuid: String?
    var token: String?
    var online: Bool
    var created: String?
    var updated: String?
}
