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
    @AppStorage("language") private var language = "en"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CustomLogo(width: 240, height: 220)
                        .padding(.top, 20)
                    Spacer().frame(height: 45)
                    
                    CustomTextField(imageName: "avatar", placeholder: "login-User", text: $viewModel.username)
                        .padding(.bottom, 36)
                    
                    SecureFields(title: "login-Password", text: $viewModel.password, imageName: "padlock")
                        .padding(.bottom, 36)
                    
                    BiometricButton(action: {
                        viewModel.authenticateWithBiometrics()
                    }, imageName: "faceid")
                    .padding(.bottom, 36)
                    
                    CustomButton(title: "login-login") {
                        viewModel.login()
                    }
                    .padding(.bottom, 55)
                    
                    navigateToRegister()
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
            .navigationDestination(isPresented: $isNavigationToRegister) {
                RegisterView()
            }
            .navigationDestination(isPresented: $viewModel.isLoginSuccessful) {
                HomeView()
            }
        }
    }
    
    private func alert() -> Alert {
        Alert(title: Text("login-alert-title"), message: Text(viewModel.errorMessage ?? "login-alert-error-not-found"), dismissButton: .default(Text("login-alert-error-button"), action: {
            viewModel.resetAlerts()
        }))
    }
    
    private func navigateToRegister() -> some View {
        HStack {
            Text("login-No account")
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            Button(action: {
                isNavigationToRegister = true
            }) {
                Text("login-Register")
                    .foregroundColor(Color("Blue"))
            }
            .padding(.horizontal, 10)
        }
        .padding(.bottom,40)
    }
}

#Preview{
    LoginView()
}
