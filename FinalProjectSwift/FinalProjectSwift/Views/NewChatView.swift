//
//  NewChatView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 22/7/24.
//

import SwiftUI

struct NewChatView: View {
    @StateObject private var newChatViewModel = NewChatViewModel()
    var onUpdate: () -> Void
    
    var body: some View {
            VStack {
                HStack {
                    Text("Nuevo Chat")
                        .padding(16)

                }
                SearcField(imageName: "magnifyingglass", placeholder: "Buscar", text: $newChatViewModel.search).onChange(of: newChatViewModel.search) { newValue in
                    newChatViewModel.getChatFilter()
                }
                ZStack {
                    List{
                        ForEach(newChatViewModel.chatFilter){ newChat in
                            Text(newChat.nick ?? "Usuario Desconocido")
                                .onTapGesture {
                                    newChatViewModel.showAlert = true
                                    newChatViewModel.createdChat(target: newChat.id)
                                    onUpdate()
                                }
                               // .alert(isPresented: $newChatViewModel.showAlert)
                           // Alert(title: ("Quieres crear un nuevo chat con \(newChat.nick)?"))
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    }.scrollContentBackground(.hidden)
                        VStack {
                            ForEach(newChatViewModel.scrollLetters, id: \.self) { letter in
                                Text(String(letter))
                                    .font(.system(size: 12))
                                    .frame(height: 15)
                            }
                        }
                        .padding(.leading, 350)
                }
            }
    }
}

#Preview {
    NewChatView(onUpdate: {
        
    })
}
