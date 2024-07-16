//
//  ProfileSettingsView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 16/7/24.
//

import SwiftUI

struct ProfileSettingsView: View {
    
    @StateObject private var viewModel = ProfileSettingsViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ZStack(alignment: .topLeading) {
                        background
                        VStack(spacing: 0) {
                            goToHome
                            Spacer()
                            userData()
                        }
                    }
                    buttons()
                        .padding(.top, 40)
                }
            }
            
            signOffButton
                .padding(.bottom, 20)
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.fetchUserData()
        }
    }
    private var background: some View {
        Color("Blue")
            .frame(height: 310)
            .edgesIgnoringSafeArea(.top)
    }
    private var goToHome: some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "arrow.left")
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
        VStack (spacing: 45) {
            ForEach(viewModel.buttons) { button in
                
                CustomProfileButton (
                    title: button.title, iconName: button.iconName, action: button.action
                )
            }
        }
    }
    private func userData() -> some View {
        VStack(spacing: 10) {
            if let avatarURL = viewModel.user.avatar, !avatarURL.isEmpty {
                AsyncImage(url: URL(string: avatarURL)) { image in
                    image.resizable()
                } placeholder: {
                    Image("defaultAvatar")
                        .resizable()
                }
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
            
        }) {
            Text("Cerrar Sesion")
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
