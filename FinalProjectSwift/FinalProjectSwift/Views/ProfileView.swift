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
        NavigationView {
            VStack{
                
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
            .navigationTitle("Ajustes de perfil")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
            }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
            })
        }
        
    }
    
    private func editProfile() -> some View {
            VStack {
                HStack(alignment: .top, spacing: 0) {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 60, height: 55)
                            .padding(.leading, 2)
                            .padding(.top, 10)
                        
                        Button(action: {
                            
                        }) {
                            Text("Editar")
                                .foregroundColor(Color("Blue"))
                                .font(.caption)
                        }
                        .padding(.top, 10)
                        .padding(.leading, 2)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ingresa tu nombre y añade una foto de perfil (Opcional)")
                            .foregroundColor(.black)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 10)
                        
                       
                    }
                    .padding(.leading, 10)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                Divider()
                    .padding(.vertical, 8)
                
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
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .frame(width: 335, height: 160)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.top, 30)
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
