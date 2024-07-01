//
//  RegisterView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 1/7/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        
        ScrollView {
            VStack() {
                
                CustomLogo(widht: 240, height: 220)
                Spacer().frame(height: 50)
                
                CustomTextField(imageName: "person" , placeholder: "Usuario", text: $username)
                    .padding(.bottom, 36)
                CustomTextField(imageName: "lock" , placeholder: "Contraseña", text: $password, isSecure: true)
                    .padding(.bottom, 36)
                CustomTextField(imageName: "lock", placeholder: "Repetir Contraseña", text: $confirmPassword, isSecure: true)
                    .padding(.bottom, 36)
                
                CustomButton(title: "Registarse") {
                    
                }
                .padding(.bottom, 55)
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
