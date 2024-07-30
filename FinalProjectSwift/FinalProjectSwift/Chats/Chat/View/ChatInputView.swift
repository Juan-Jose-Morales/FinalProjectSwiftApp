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

    var body: some View {
        HStack {
            Button(action: attachAction) {
                Image("Attach")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.leading, 5)
            .padding(.trailing, 5)
            
            TextField("Envia un mensaje...", text: $messageText)
                .padding(10)
                .background(Color.white)
                .cornerRadius(15)
                .foregroundColor(.black)
                .lineLimit(1)
                .padding(.horizontal, 15)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            
            Button(action: {
                print("Send button pressed")
                sendAction()
            }) {
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
        ChatInputView(messageText: $messageText, sendAction: {}, attachAction: {})
    }
}
