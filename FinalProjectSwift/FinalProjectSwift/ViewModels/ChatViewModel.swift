//
//  ChatViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 18/7/24.
//

import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messageText: String = ""
    @Published var messages: [String] = []
    
    let user: User
    @ObservedObject var changeProfileViewModel: ChangeProfileViewModel
    
    init(user: User) {
        self.user = user
        self.changeProfileViewModel = ChangeProfileViewModel()
    }
    
    func sendMessage() {
        if !messageText.isEmpty {
            messages.append(messageText)
            messageText = ""
        }
    }
    
    func attachFile() {
       
    }
}

