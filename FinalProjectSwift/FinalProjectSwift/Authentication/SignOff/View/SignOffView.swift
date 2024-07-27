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
    @State private var showConfirmationAlert = false
    @State private var showProgress = false
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomNavigationBar(title: "Cerrar Sesión", titleColor: .red, buttonColor: .red, onBack: {
                    isNavigateToProfileSettingsView = true
                })
                messageToUser
                Spacer().frame(height: 60)
                signOffButton
                Spacer()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Error desconocido"), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showConfirmationAlert) {
                Alert(
                    title: Text("Confirmación"),
                    message: Text("¿Estás seguro que quieres cerrar sesión?"),
                    primaryButton: .default(Text("Sí"), action: {
                        viewModel.signOff()
                    }),
                    secondaryButton: .cancel(Text("No"))
                )
            }
            .onChange(of: viewModel.isSignOffSuccessful) { isSignOff in
                if isSignOff {
                    isNavigateToLogin = true
                }
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
        HStack(alignment: .top) {
            Image("Warning")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading)
            
            Text("¿Deseas cerrar sesión en este dispositivo?")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
            
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
            showConfirmationAlert = true
        }) {
            Text("Cerrar sesión")
                .foregroundColor(.red)
                .frame(width: 305, height: 30)
                .background(Color("GrayText"))
                .cornerRadius(16)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    SignOffView()
}
