//
//  MessageListResponse.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 22/7/24.
//

import Foundation

struct MessageListResponse: Decodable {
    let count: Int
    let rows: [Message]
}
