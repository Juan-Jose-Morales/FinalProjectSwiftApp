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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CustomLogo(width: 240, height: 220)
                        .padding(.top, 50)
                    Spacer().frame(height: 45)
                    CustomTextField(imageName: "person", placeholder: "Usuario", text: $viewModel.username)
                        .padding(.bottom, 36)
                    SecureFields(title: "Contraseña", text: $viewModel.password, imageName: "lock")
                        .padding(.bottom, 36)
                    SecureFields(title: "Confirmar Contraseña", text: $viewModel.confirmPassword, imageName: "lock")
                        .padding(.bottom, 36)
                    CustomButton(title: "Registrar") {
                        viewModel.register()
                    }
                    .padding(.bottom, 55)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Error desconocido"), dismissButton: .default(Text("OK"), action: { viewModel.resetAlerts() }))
                }
                .onReceive(viewModel.$showSuccessAlert) { success in
                    if success {
                        presentationMode.wrappedValue.dismiss() // Dismiss RegisterView on success
                        // Navigate to LoginView here (explained below)
                    }
                }
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
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
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Iniciar Sesión")
                .foregroundColor(Color("Blue"))
        }
    }
}
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
