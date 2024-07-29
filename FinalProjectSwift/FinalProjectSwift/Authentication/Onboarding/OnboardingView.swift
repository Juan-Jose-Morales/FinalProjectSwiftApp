//
//  OnboardingView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 29/7/24.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: LoginView()) {
                        Text("Skip")
                            .foregroundColor(Color("Blue"))
                            .padding()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal)
                
                Spacer()
                TabView(selection: $currentPage) {
                    OnboardingPageView(imageName: "appLogo", title: "Bienvenidos a EasyChat", description: "Es una app en la cual puedes comunicarte con tus mejores amigos, enviando mensajes en línea, creando chats con usuarios que tengan la app.")
                        .tag(0)
                    OnboardingPageView(imageName: "messages", title: "Envía Mensajes", description: "Comunícate con tus amigos en tiempo real.")
                        .tag(1)
                    OnboardingPageView(imageName: "conectado", title: "Observa el estado actual de tus amigos", description: "Puedes ver si tus amigos están conectados o no")
                        .tag(2)
                    OnboardingPageView(imageName: "eliminar", title: "Eliminar Chats", description: "Elimina un chat, pero solo podrás eliminar un chat que has creado tú.")
                        .tag(3)
                    OnboardingPageView(imageName: "profileImage", title: "Perfil Personalizado", description: "Selecciona una foto de perfil en local y personaliza tu experiencia.")
                        .tag(4)
                    FinalOnboardingPageView()
                        .tag(5)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 500)
                
                HStack(spacing: 8) {
                    ForEach(0..<6) { index in
                        Button(action: {
                            currentPage = index
                        }) {
                            Circle()
                                .fill(index == currentPage ? Color.blue : Color.gray)
                                .frame(width: 10, height: 10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 16)

                HStack {
                    Button(action: {
                        if currentPage > 0 {
                            currentPage -= 1
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color("Blue"))
                    }
                    .padding()

                    Spacer()

                    Button(action: {
                        if currentPage < 5 {
                            currentPage += 1
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color("Blue"))
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
