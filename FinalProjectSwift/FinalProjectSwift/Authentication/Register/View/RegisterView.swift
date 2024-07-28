//
//  RegisterView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 1/7/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var offset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CustomLogo(width: 240, height: 220)
                        .padding(.top, 50)
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
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Error desconocido"), dismissButton: .default(Text("OK"), action: { viewModel.resetAlerts() }))
                }
                .alert(isPresented: $viewModel.showSuccessAlert) {
                    Alert(title: Text("Registro Exitoso"), message: Text("El registro fue exitoso"), dismissButton: .default(Text("OK"), action: {
                        viewModel.resetAlerts()
                        presentationMode.wrappedValue.dismiss()
                    }))
                }
            }
            .background(
                Color.white
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        DismissKeyboardGesture()
                    )
            )
    
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
                presentationMode.wrappedValue.dismiss()
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
