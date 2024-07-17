//
//  SignOffView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import SwiftUI

struct SignOffView: View {
    var body: some View {
        
        NavigationView {
            VStack {
                messageToUser
                Spacer().frame(height: 60)
                signOffButton
                Spacer()
            }
            .navigationTitle("Cerrar sesión")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
            }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.red)
            })
        }
    }
    private var messageToUser: some View {
        HStack{
            Image("Warning")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading)
            
            Text("¿Deseas cerrar sesion en este dispositivo?")
                .padding(.leading)
            
            Spacer()
            
        }
        .frame(width: 335, height: 70)
        .background(Color("GrayText"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        .padding(.top, 20)
    }
    private var signOffButton: some View {
        Button(action: {
            
        }) {
            Text("Cerrar sesión")
                .foregroundColor(.red)
                .frame(width: 305, height: 30)
                .background(Color("GrayText"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                
        }
    }
    
}

#Preview {
    SignOffView()
}
