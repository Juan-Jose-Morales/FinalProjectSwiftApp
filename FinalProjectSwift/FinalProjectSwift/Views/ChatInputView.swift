//
//  ChatInputView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 19/7/24.
//

import SwiftUI

struct ChatInputView: View {
    @Binding var messageText: String
    
    var sendAction: () -> Void
    var attachAction: () -> Void
    @StateObject private var keyboardResponder = KeyboardResponder()

    var body: some View {
        HStack {
            Button(action: attachAction) {
                Image("Attach")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.leading, 15)
            
            StyledTextField(placeholder: "Envia un mensaje", text: $messageText)
            
            Button(action: sendAction) {
                Image("Send")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(Color("Blue"))
        .offset(y: keyboardResponder.currentHeight > 0 ? -keyboardResponder.currentHeight : 0)
        .animation(.easeOut(duration: 0.3), value: keyboardResponder.currentHeight)
        .padding(.bottom, keyboardResponder.currentHeight > 0 ? keyboardResponder.currentHeight : 0)
        .padding(.top, 15)
    }
}

#Preview("ChatInputView Preview") {
    @State var messageText = ""
    return ChatInputView(messageText: $messageText, sendAction: {}, attachAction: {})
}
