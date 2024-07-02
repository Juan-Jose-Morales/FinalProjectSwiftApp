//
//  User.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 2/7/24.
//

import Foundation

struct User: Codable {
    
    let id: String?
    let login: String
    let password: String
    let nick: String
    let avatar: String?
    let uuid: String?
    let token: String?
    let online: Bool
    let created: String?
    let updated: String?
}
