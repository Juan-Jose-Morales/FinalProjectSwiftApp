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
    @State private var isNavigationToHome = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CustomLogo(width: 240, height: 220)
                        .padding(.top, 50)
                    Spacer().frame(height: 45)
                    
                    CustomTextField(imageName: "person", placeholder: "Usuario", text: $viewModel.username)
                        .padding(.bottom, 36)
                    
                    SecureFields(title: "Contraseña", text: $viewModel.password, imageName: "lock")
                        .padding(.bottom, 36)
                    
                    BiometricButton(action: {
                        viewModel.authenticateWithBiometrics()
                    }, imageName: "person.fill.viewfinder")
                    .padding(.bottom, 36)
                    
                    CustomButton(title: "Iniciar Sesión") {
                        viewModel.login()
                        isNavigationToHome = true
                    }
                    .padding(.bottom, 55)
                    
                    .navigationDestination(isPresented: $isNavigationToRegister) {
                        RegisterView()
                    }
                    .navigationDestination(isPresented: $isNavigationToHome) {
                        HomeView()
                    }
                    
                    navigateToRegister()
                }
                .padding(.horizontal, 40)
                .frame(maxWidth: .infinity)
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .alert(isPresented: $viewModel.showAlert, content: alert)
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
            
            Button(action: {
                isNavigationToRegister = true
            }) {
                Text("Regístrate")
                    .foregroundColor(Color("Blue"))
            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}




