//
//  ChatInputView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 19/7/24.
//

import SwiftUI

struct ChatInputView: View {
    @Binding var messageText: String
    @State private var showBlockedFunctionalityAlert = false
    var sendAction: () -> Void
    var attachAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                showBlockedFunctionalityAlert = true
            }) {
                Image("Attach")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .alert(isPresented: $showBlockedFunctionalityAlert) {
                Alert(
                    title: Text("En este preciso instante estamos en la fase de desarrollo de este apartado en concreto."),
                    message: Text("Disculpe las molestias."),
                    dismissButton: .default(Text("Aceptar"))
                )
            }
            .padding(.leading, 15)
            
            ZStack(alignment: .leading) {
                if messageText.isEmpty {
                    Text("Envia un mensaje")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 15)
                }
                TextField("", text: $messageText)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
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
        ChatInputView(messageText: $messageText, sendAction: {}, attachAction: {})
    }
}
