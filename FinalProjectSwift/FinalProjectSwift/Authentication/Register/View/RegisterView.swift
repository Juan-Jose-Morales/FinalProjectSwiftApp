//
//  RegisterView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 1/7/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @State private var isNavigationToLogin = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CustomLogo(width: 240, height: 220)
                        .padding(.top, 30)
                    Spacer().frame(height: 45)
                    CustomTextField(imageName: "avatar", placeholder: "Usuario", text: $viewModel.username)
                        .padding(.bottom, 25)
                    CustomTextField(imageName: "avatar", placeholder: "Nick", text: $viewModel.nickname)
                        .padding(.bottom, 25)
                    SecureFields(title: "Contraseña", text: $viewModel.password, imageName: "padlock")
                        .padding(.bottom, 25)
                    SecureFields(title: "Repetir Contraseña", text: $viewModel.confirmPassword, imageName: "padlock")
                        .padding(.bottom, 25)
                    
                    CustomButton(title: "Registrar") {
                        viewModel.register()
                    }
                    .padding(.bottom, 30)
                    
                    navigateToLogin()
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
                .frame(maxWidth: .infinity)
            }
            .background(
                Color.white
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        DismissKeyboardGesture()
                    )
            )
            .navigationBarHidden(true)
            .alert(isPresented: $viewModel.showAlert, content: alert)
            .navigationDestination(isPresented: $isNavigationToLogin) {
                LoginView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func alert() -> Alert {
        Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Error desconocido"), dismissButton: .default(Text("OK"), action: {
            viewModel.resetAlerts()
        }))
    }
    
    private func navigateToLogin() -> some View {
        HStack {
            Text("¿Ya tienes cuenta?")
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            Button(action: {
                isNavigationToLogin = true
            }) {
                Text("Iniciar Sesión")
                    .foregroundColor(Color("Blue"))
            }
        }
    }
}

#Preview{
    RegisterView()
}
