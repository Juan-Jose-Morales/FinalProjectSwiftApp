//
//  ChangeProfileView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import SwiftUI

enum Origin {
    case home
    case profile
}

struct ChangeProfileView: View {
    @ObservedObject var viewModel = ChangeProfileViewModel()
    @State private var isNavigateBack = false
    let origin: Origin
    @EnvironmentObject var profileViewModel: ProfileViewModel

    var body: some View {
        NavigationStack {
            VStack {
                userAvatar
                
                Divider()
                
                buttonsToChangePhoto()
                
                Spacer()
            }
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(sourceType: viewModel.imagePickerSource) { image in
                    if let image = image {
                        viewModel.updateProfilePhoto(image: image)
                        
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Foto de perfil")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                isNavigateBack = true
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
            })
            .navigationDestination(isPresented: $isNavigateBack) {
                if origin == .home {
                    HomeView()
                } else {
                    ProfileView(userService: UserService())
                }
            }
        }
    }
    
    private var userAvatar: some View {
        VStack {
            if let profileImage = viewModel.profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 280, height: 280)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 20)
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 262, height: 284)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
    
    private func buttonsToChangePhoto() -> some View {
        VStack(spacing: 25) {
            Spacer().frame(height: 25)
            CustomButtonProfileImage(
                title: "Tomar foto",
                action: { viewModel.takePhoto() },
                iconName: "camera",
                textColor: .black,
                iconColor: .black
            )
            
            CustomButtonProfileImage(
                title: "Seleccionar foto",
                action: { viewModel.selectPhoto() },
                iconName: "photo",
                textColor: .black,
                iconColor: .black
            )
            
            CustomButtonProfileImage(
                title: "Eliminar foto",
                action: { viewModel.deletePhoto() },
                iconName: "trash",
                textColor: .red,
                iconColor: .red
            )
        }
    }
}

#Preview {
    ChangeProfileView(origin: .home)
}

