//
//  LoginView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 1/7/24.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isNavigationToRegister = false
    @State private var isShowingProgress = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isShowingProgress {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .opacity(1)
                } else {
                    ScrollView {
                        VStack {
                            CustomLogo(width: 240, height: 220)
                                .padding(.top, 50)
                            Spacer().frame(height: 45)
                            
                            CustomTextField(imageName: "avatar", placeholder: "Usuario", text: $viewModel.username)
                                .padding(.bottom, 36)
                            
                            SecureFields(title: "Contraseña", text: $viewModel.password, imageName: "padlock")
                                .padding(.bottom, 36)
                            
                            BiometricButton(action: {
                                viewModel.authenticateWithBiometrics()
                            }, imageName: "faceid")
                            .padding(.bottom, 36)
                            
                            CustomButton(title: "Iniciar Sesión") {
                                viewModel.login()
                            }
                            .padding(.bottom, 55)
                            
                            navigateToRegister()
                        }
                        .padding(.horizontal, 40)
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(isShowingProgress)
                }
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
            .navigationDestination(isPresented: $isNavigationToRegister) {
                RegisterView()
            }
            .navigationDestination(isPresented: $viewModel.isLoginSuccessful) {
                HomeView()
            }
        }
    }
    
    private func alert() -> Alert {
        Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Error desconocido"), dismissButton: .default(Text("OK"), action: {
            viewModel.resetAlerts()
        }))
    }
    
    private func navigateToRegister() -> some View {
        HStack {
            Text("¿No tienes cuenta?")
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            Button(action: {
                isNavigationToRegister = true
            }) {
                Text("Regístrate")
                    .foregroundColor(Color("Blue"))
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview{
    LoginView()
}
