//
//  SendMessageRequest.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 22/7/24.
//

import Foundation

struct SendMessageRequest: Encodable {
    let text: String
    let chatId: String
}
