//
//  ProfileView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 16/7/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    
    init(userService: UserService) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(userService: userService))
    }
    
    var body: some View {
        VStack{
            tapBar
                .padding()
            
            if viewModel.isLoading {
                progressView
            }else{
                
                editProfile()

            }
            
            Spacer().frame(height: 40)
            
            Divider()
                .padding(.horizontal)
            
            Spacer().frame(height: 40)
            
            blocked
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
    private var tapBar: some View{
        HStack{
            Button(action: {
                
            }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
            }
            Spacer()
            Text("Ajustes de perfil")
                .font(.headline)
                .bold()
                .foregroundColor(.black)
            Spacer()
            
            Image(systemName: "arrow.left")
                .opacity(0)
        }
    }
    private func editProfile() -> some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                VStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.leading, 16)
                    
                    Button(action: {
                        
                    }) {
                        Text("Editar")
                            .foregroundColor(Color("Blue"))
                            .font(.caption)
                    }
                    .padding(.top, 5)
                    .padding(.leading, 16)
                }
                
                VStack() {
                    Text("Ingresa tu nombre y añade una foto de perfil (Opcional)")
                        .foregroundColor(.black)
                        .padding(.bottom, 30)
                    
                    Divider()
                        .frame(maxWidth: .infinity)
    
                    HStack {
                        Text(viewModel.userName.isEmpty ? "Usuario" : viewModel.userName)
                            .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("Editar")
                                .foregroundColor(Color("Blue"))
                        }
                       
                    }
                    
                }
                .padding(.trailing, 16)
            }
        }
        .frame(width: 335, height: 150)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.top, 16)
    }
    private var progressView: some View {
        ProgressView()
            .frame(width: 335, height: 133)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.top, 16)
    }
    private var blocked: some View {
        Button(action: {
            
        }) {
            HStack {
                Text("Bloqueados")
                    .foregroundColor(.red)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.red)
            }
            .frame(width: 300, height: 40)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView(userService: UserService())
}
