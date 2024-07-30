//
//  ProfileView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 16/7/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    @State private var isNavigateToChangeProfile = false
    @State private var isNavigateToProfileSettings = false
    @State private var isEditingUserName = false
    @State private var keepSessionActive = false
    @State private var showBlockedFunctionalityAlert = false
    
    init(userService: UserService) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(userService: userService))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    CustomNavigationBar(title: "settings-profile2", titleColor: .black, buttonColor: .black, onBack: {
                        isNavigateToProfileSettings = true
                    })
                    if viewModel.isLoading {
                        progressView
                    } else {
                        editProfile()
                    }
                    Spacer().frame(height: 40)
                    
                    Toggle(isOn: $keepSessionActive) {
                        Text("settings-profile2-session")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 40)
                    .onChange(of: keepSessionActive) { value in
                        if value {
                            keepSessionActive = false
                            showBlockedFunctionalityAlert = true
                        }
                    }
                    Spacer().frame(height: 40)
                    
                    Toggle(isOn: $viewModel.isOnline) {
                        Text("settings-profile2-online")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 40)
                    .onChange(of: viewModel.isOnline) { isOnline in
                        viewModel.updateOnlineStatus(isOnline: isOnline)
                    }
                    Spacer().frame(height: 40)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Spacer().frame(height: 40)
                    blocked
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isNavigateToChangeProfile) {
                ChangeProfileView(origin: .profile)
            }
            .navigationDestination(isPresented: $isNavigateToProfileSettings) {
                ProfileSettingsView()
                
            }
            .alert(isPresented: $showBlockedFunctionalityAlert) {
                Alert(
                    title: Text("blocked-button-alert-title"),
                    message: Text("blocked-button-alert-message"),
                    dismissButton: .default(Text("blocked-button-alert-primary-button")) {
                        
                    }
                )
            }
        }
    }
    
    
    private func editProfile() -> some View {
        VStack {
            HStack(alignment: .top, spacing: 0) {
                VStack {
                    if let profileImage = viewModel.profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .frame(width: 60, height: 55)
                            .padding(.leading, 2)
                            .padding(.top, 10)
                            .clipShape(Circle())
                    } else {
                        Image("defaultAvatar")
                            .resizable()
                            .frame(width: 60, height: 55)
                            .padding(.leading, 2)
                            .padding(.top, 10)
                    }
                    
                    Button(action: {
                        isNavigateToChangeProfile = true
                    }) {
                        Text("settings-profile2-button-edit")
                            .foregroundColor(Color("Blue"))
                        
                    }
                    .padding(.top,5)
                    .padding(.leading, 2)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("settings-profile2-photo")
                        .foregroundColor(.black)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 10)
                }
                .padding(.leading, 10)
                .padding(.top, 10)
                .padding(.bottom, 30)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            Divider()
                .padding(.vertical, 8)
            
            HStack {
                
                Text(viewModel.userName.isEmpty ? "Usuario" : viewModel.userName)
                    .foregroundColor(.black)
                
                
                Spacer()
                
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
            showBlockedFunctionalityAlert.toggle()
        }) {
            HStack {
                Text("settings-profile2-blocked")
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
        .shadow(radius: 5)
    }
}

#Preview {
    ProfileView(userService: UserService())
}
