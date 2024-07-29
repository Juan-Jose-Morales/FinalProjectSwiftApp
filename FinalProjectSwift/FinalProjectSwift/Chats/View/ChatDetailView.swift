//
//  ChatDetailView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 28/7/24.
//

import SwiftUI

struct ChatDetailView: View {
    @StateObject var chatDetailModel: ChatDetailViewModel
    @State private var showBlockedFunctionalityAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack(spacing: 0) {
                        ZStack {
                            Color("Blue")
                                .edgesIgnoringSafeArea(.top)
                                .frame(height: 310)
                            VStack {
                                HStack {
                                    NavigationLink(destination: ChatView(chatViewModel: ChatViewModel(chatId: chatDetailModel.chatId, chatList: chatDetailModel.chat))) {
                                        Image("ArrowLeft")
                                            .resizable()
                                            .frame(width: 35, height: 25)
                                            .foregroundColor(.black)
                                            .padding()
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(chatDetailModel.color)
                                        .frame(width: 170, height: 170)
                                    
                                    Text(chatDetailModel.capitalizedName)
                                        .bold()
                                        .foregroundColor(.white)
                                        .font(.system(size: 150))
                                }
                                .padding(16)
                                
                                Text(chatDetailModel.name)
                                    .bold()
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                        }.padding(.bottom, 20)
                        VStack{
                            HStack {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .frame(width: 20, height: 20)
                                    .bold()
                                    .padding(.leading, 20)
                                
                                Text("Fotos recientes")
                                    .bold()
                                    .padding(.leading, 20)
                                
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            
                            Divider()
                                .background(Color.gray)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                                ForEach(0..<9) { _ in
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 65, height: 65)
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 5)
                                }
                            }
                            .padding()
                            
                            Divider()
                                .background(Color.gray)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                            blocked
                        }.background(.white)
                    }
                    .onAppear {
                        UINavigationBar.appearance().backgroundColor = UIColor(named: "Blue")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .alert(isPresented: $showBlockedFunctionalityAlert) {
                        Alert(
                            title: Text("En este preciso instante estamos en la fase de desarrollo de este apartado en concreto."),
                            message: Text("Disculpe las molestias."),
                            dismissButton: .default(Text("Aceptar")))
                    }
                }
                .navigationBarBackButtonHidden()
            }.background(Color("Blue"))
        }
    }
    private var blocked: some View {
        Button(action: {
            showBlockedFunctionalityAlert.toggle()
        }) {
            HStack {
                Text("Bloquear")
                    .foregroundColor(.red)
            }
            
            .frame(width: 300, height: 40)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            
        }
        .padding(.horizontal)
        .padding(.top, 16)
        .padding(.bottom, 25)
        .shadow(radius: 5)
    }
}
