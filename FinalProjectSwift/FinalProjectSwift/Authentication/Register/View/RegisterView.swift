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
    @State private var isNavigationToOnboarding = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CustomLogo(width: 240, height: 220)
                        .padding(.top, 20)
                    
                    Spacer().frame(height: 45)
                    
                    CustomTextField(imageName: "avatar", placeholder: "register-User", text: $viewModel.username)
                        .padding(.bottom, 25)
                    
                    CustomTextField(imageName: "avatar", placeholder: "register-Nick", text: $viewModel.nickname)
                        .padding(.bottom, 25)
                    
                    SecureFields(title: "register-password", text: $viewModel.password, imageName: "padlock")
                        .padding(.bottom, 25)
                    
                    SecureFields(title: "register-confirm-password", text: $viewModel.confirmPassword, imageName: "padlock")
                        .padding(.bottom, 25)
                    
                    CustomButton(title: "register-button") {
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
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage ?? "Error desconocido"), dismissButton: .default(Text("OK"), action: {
                    viewModel.resetAlerts()
                    if viewModel.isSuccess {
                        isNavigationToOnboarding = true
                    }
                }))
            }
            .navigationDestination(isPresented: $isNavigationToLogin) {
                LoginView()
            }
            .navigationDestination(isPresented: $isNavigationToOnboarding) {
                OnboardingView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func navigateToLogin() -> some View {
        HStack {
            Text("register-do-you-have-account")
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            Button(action: {
                isNavigationToLogin = true
            }) {
                Text("register-log-in")
                    .foregroundColor(Color("Blue"))
            }
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    RegisterView()
}
