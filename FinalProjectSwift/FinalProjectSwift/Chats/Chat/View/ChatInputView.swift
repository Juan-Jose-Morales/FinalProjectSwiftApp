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
        HStack{
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
            .padding(.leading, 5)
            .padding(.trailing, 5)
            
            HStack(spacing: 10) {
                withAnimation(.easeInOut) {
                    TextField("", text: $messageText, axis: .vertical)
                        .placeholder(when: messageText.isEmpty) {
                            Text("Envia un mensaje...")
                                .foregroundColor(.secondary)
                        }
                        .lineLimit(...7)
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.white)
            .cornerRadius(10)
            
            
            Button(action: sendAction) {
                Image("Send")
                .resizable()
                .frame(width: 24, height: 24)
            }
            
        }
        .padding(.leading , 10)
        .padding(.trailing, 10)
        .padding(.vertical, 7)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 55)
        .background(Color("Blue"))
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.3), value: messageText)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}

struct ChatInputView_Previews: PreviewProvider {
    @State static var messageText = ""
    static var previews: some View {
        ChatInputView(messageText: $messageText, sendAction: {}, attachAction: {})
    }
}
