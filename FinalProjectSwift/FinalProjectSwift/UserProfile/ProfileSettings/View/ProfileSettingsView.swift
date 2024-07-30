//
//  ProfileSettingsView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 16/7/24.
//

import SwiftUI

struct ProfileSettingsView: View {
    
    @StateObject private var viewModel = ProfileSettingsViewModel()
    @State private var isNavigatingToProfile = false
    @State private var isNavigatingToHome = false
    @State private var isNavigationToSignOff = false
    @State private var showBlockedFunctionalityAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        ZStack(alignment: .topLeading) {
                            backgroundBlue
                            VStack(spacing: 0) {
                                goToHome
                                Spacer()
                                userData()
                            }
                        }
                        buttons()
                            .padding(.top, 30)
                        
                        Spacer()
                        
                        signOffButton
                            .padding(.top, 40)
                        
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isNavigatingToProfile) {
                ProfileView(userService: UserService())
            }
            .navigationDestination(isPresented: $isNavigatingToHome) {
                HomeView()
            }
            .navigationDestination(isPresented: $isNavigationToSignOff) {
                SignOffView()
            }
            .alert(isPresented: $showBlockedFunctionalityAlert) {
                Alert(
                    title: Text("profile-settings-button-title"),
                    message: Text("profile-settings-button-message"),
                    dismissButton: .default(Text("profile-settings-button-primary"))
                )
            }
        }
    }
    
    private var backgroundBlue: some View {
        Color("Blue")
            .frame(height: 310)
            .edgesIgnoringSafeArea(.top)
    }
    
    private var goToHome: some View {
        HStack {
            Button(action: {
                isNavigatingToHome = true
            }) {
                Image("ArrowLeft")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .padding(.top, 60)
                    .padding(.leading)
            }
            Spacer()
        }
    }
    
    private func buttons() -> some View {
        VStack(spacing: 45) {
            ForEach(viewModel.buttons) { button in
                CustomProfileButton(title: button.title, iconName: button.iconName) {
                    if button.title == "profile-settings-profile" {
                        isNavigatingToProfile = true
                    }
                    else if button.title == "profile-storage" || button.title == "profile-languages-settings" {
                        showBlockedFunctionalityAlert.toggle()
                    }
                }
            }
        }
    }
    
    private func userData() -> some View {
        VStack(spacing: 10) {
            if let profileImage = viewModel.profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 182, height: 154)
                    .clipShape(Circle())
            } else {
                Image("defaultAvatar")
                    .resizable()
                    .frame(width: 182, height: 154)
                    .clipShape(Circle())
            }
            Text(viewModel.user.nick ?? "Usuario")
                .foregroundColor(.white)
                .font(.title)
                .padding(.top, 10)
                .padding(.bottom, 20)
        }
    }
    
    private var signOffButton: some View {
        Button(action: {
            isNavigationToSignOff = true
        }) {
            Text("profile-log-out")
                .foregroundColor(Color("Red"))
                .frame(width: 305, height: 30)
                .background(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("Gray"), lineWidth: 1)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10))
        }
    }
}

#Preview {
    ProfileSettingsView()
}
