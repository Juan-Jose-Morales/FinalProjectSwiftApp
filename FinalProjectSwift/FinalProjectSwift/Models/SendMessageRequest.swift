//
//  SendMessageRequest.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 22/7/24.
//

import Foundation

struct SendMessageRequest: Encodable {
    let chat: String
    let source: String
    let message: String
}
