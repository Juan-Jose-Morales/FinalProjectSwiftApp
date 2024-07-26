//
//  MessageViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 26/7/24.
//

import Foundation
import Combine

class MessageViewModel: ObservableObject {
    @Published var message: Message
    @Published var source: String = ""

    init(message: Message) {
        self.message = message
        self.source = UserDefaults.standard.string(forKey: "id") ?? ""
    }
}
