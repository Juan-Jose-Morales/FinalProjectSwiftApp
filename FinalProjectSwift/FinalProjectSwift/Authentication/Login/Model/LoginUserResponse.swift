//
//  LoginUserResponse.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 10/7/24.
//

import Foundation

struct LoginUserResponse: Codable {
    let token: String
    let user: User
}

struct ErrorResponse: Codable {
    let message: String
}
