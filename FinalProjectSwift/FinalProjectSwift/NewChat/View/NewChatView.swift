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
    @State private var navigateNewChat = false
    @State private var navigateHome = false
    
    var body: some View {
        NavigationStack {
            VStack {
                    HStack {
                        Spacer()
                        Text("Nuevo Chat")
                            .bold()
                            .padding(.leading, 60)
                            .padding(.vertical ,16)
                            Spacer()
                        Button(action: {
                            navigateHome = true
                        }, label: {
                            Image(systemName: "xmark.app")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                                .clipShape(Circle())
                        }).padding(.horizontal, 20)
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
                                                        .foregroundColor(newChatViewModel.randomColor())
                                                        .frame(width: 40, height: 40)
                                                    
                                                    Text(newChatViewModel.capitalizedName(name: newChat.nick ?? "?"))
                                                        .foregroundStyle(.white)
                                                }.padding(.horizontal, 8)
                                                Text(newChatViewModel.nameComprobation(newUser: newChat))
                                                Spacer()
                                            }.padding(.vertical, 1)
                                        }.padding(.vertical, 5)
                                }.onTapGesture {
                                        newChatViewModel.showAlert = true
                                        newChatViewModel.alertNewChat = newChat
                                }.alert(isPresented: $newChatViewModel.showAlert){
                                    Alert(title: Text("Quieres crear un nuevo chat con \(newChatViewModel.alertNewChat?.nick ?? "Usuario Desconocido")"), primaryButton: .default(Text("Sí"), action: {
                                        newChatViewModel.createdChat(target: newChatViewModel.alertNewChat?.id ?? "")
                                        onUpdate()
                                        navigateNewChat = true
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
            }.navigationDestination(isPresented: $navigateNewChat) {
                ChatView(chatViewModel: ChatViewModel(chatId: newChatViewModel.alertNewChat?.id ?? "", chatList: newChatViewModel.convertToChatList(newChat: newChatViewModel.alertNewChat!)))
            }
            .navigationDestination(isPresented: $navigateHome) {
                HomeView()
            }
        }
    }
}

#Preview {
    NewChatView( onUpdate: {
        
    })
}
