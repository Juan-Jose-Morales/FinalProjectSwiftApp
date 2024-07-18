//
//  SignOffView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import SwiftUI

struct SignOffView: View {
    @StateObject private var viewModel = SignOffViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isNavigateToLogin = false
    @State private var isNavigateToProfileSettingsView = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                messageToUser
                Spacer().frame(height: 60)
                signOffButton
                Spacer()
            }
            .navigationTitle("Cerrar sesión")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                isNavigateToProfileSettingsView = true
            }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.red)
            })
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Error desconocido"), dismissButton: .default(Text("OK")))
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isNavigateToLogin) {
                LoginView()
            }
            .navigationDestination(isPresented: $isNavigateToProfileSettingsView) {
                ProfileSettingsView()
            }
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
            isNavigateToLogin = true
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
