//
//  RegisterView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 1/7/24.
//

import SwiftUI

struct RegisterView: View {
    
   @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        ScrollView {
            VStack() {
                CustomLogo(widht: 240, height: 220)
                Spacer().frame(height: 50)
                
                CustomTextField(imageName: "person" , placeholder: "Usuario", text: $viewModel.username)
                    .padding(.bottom, 36)
                SecureFields(title: "Contraseña", text: $viewModel.password, imageName: "lock")
                    .padding(.bottom, 36)
                SecureFields(title: "Repetir Contraseña", text: $viewModel.confirmPassword, imageName: "lock")
                    .padding(.bottom, 36)
                
                CustomButton(title: "Registarse") {
                    viewModel.register()
                }
                .padding(.bottom, 55)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Error Desconocido"), dismissButton: .default(Text("Aceptar")))
                }
                .alert(isPresented: $viewModel.showSuccessAlert){
                    Alert(title: Text("Exito"), message: Text("Usuario registrado correctamente"), dismissButton: .default(Text("Aceptar")))
                }
                HStack {
                    Text("¿Ya tienes cuenta?")
                        .foregroundColor(.black)
                    Button(action: {
                        
                    }) {
                        Text("Iniciar Sesión")
                            .foregroundColor(Color("Blue"))
                    }
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.bottom,30)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, 16)
        
    }
}



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
