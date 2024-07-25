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
                            
                            VStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white)
                                            .shadow(radius: 5, x: 5, y: 5)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        HStack{
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(Color("Blue"))
                                                    .frame(width: 40, height: 40)
                                                
                                                Text(newChat.nick?.prefix(1).capitalized ?? "")
                                                    .foregroundStyle(.white)
                                            }.padding(.horizontal, 8)
                                            Text(newChat.nick ?? "Usuario desconocido")
                                            Spacer()
                                        }.padding(.vertical, 8)
                                    }.padding(.vertical, 5)
                            }.onTapGesture {
                                    newChatViewModel.showAlert = true
                                    newChatViewModel.alertNewChat = newChat
                            }.alert(isPresented: $newChatViewModel.showAlert){
                                Alert(title: Text("Quieres crear un nuevo chat con \(newChatViewModel.alertNewChat?.nick ?? "Usuario Desconocido")"), primaryButton: .default(Text("Sí"), action: {
                                    newChatViewModel.createdChat(target: newChatViewModel.alertNewChat?.id ?? "")
                                    onUpdate()
                                }), secondaryButton: .cancel(Text("Cancelar")))
                            }
                        }.listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    NewChatView( onUpdate: {
        
    })
}
