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
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if messageText.isEmpty {
                    Text("Envia un mensaje")
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                        .padding(.vertical, 8)
                }
                TextField("", text: $messageText)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
            }
            .frame(height: 36)
            .padding(.horizontal, 15)

            Button(action: sendAction) {
                Image("Send")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(Color("Blue"))
        .padding(.top, 5)
    }
}

struct ChatInputView_Previews: PreviewProvider {
    @State static var messageText = ""
    static var previews: some View {
        ChatInputView(messageText: $messageText, sendAction: {})
    }
}
