//
//  LoginView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 1/7/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var loginUsername: String = ""
    @State private var loginPassword: String = ""
    @State private var isChecked = false
    var body: some View {
        ScrollView{
            VStack(){
                CustomLogo(widht: 240, height: 220)
                Spacer().frame(height: 50)
                
                CustomTextField(imageName: "person" , placeholder: "Usuario", text: $loginUsername)
                    .padding(.bottom, 36)
                SecureFields(title: "Contraseña", text: $loginPassword, imageName: "lock")
                    .padding(.bottom, 36)
                BiometricButton(action: {
                    
                }, imageName: "person.fill.viewfinder")
                HStack{
                    CheckBoxView(checked: $isChecked)
                    Text("Mantener Sesión Iniciada")
                } .padding()
                CustomButton(title: "Iniciar Sesión") {
                    
                }.padding(.bottom, 55)
                HStack {
                    Text("¿No tienes Cuenta?")
                        .foregroundColor(.black)
                    Button(action: {
                        
                    }) {
                        Text("Regístrate")
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
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

