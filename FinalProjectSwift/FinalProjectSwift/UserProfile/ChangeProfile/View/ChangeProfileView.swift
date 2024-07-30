//
//  ChangeProfileView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import SwiftUI

struct ChangeProfileView: View {
    @ObservedObject var viewModel = ChangeProfileViewModel()
    @State private var isNavigateBack = false
    let origin: Origin
    @EnvironmentObject var profileViewModel: ProfileViewModel

    var body: some View {
        NavigationStack {
            VStack {
                CustomNavigationBar(title: "photo-photoprofile", titleColor: .black, buttonColor: .black, onBack: {
                    isNavigateBack = true
                })
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
                    .scaledToFill()
                    .frame(width: 280, height: 280)
                    .clipShape(Circle())
                    .padding(.top, 20)
            } else {
                Image("defaultAvatar")
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
                title: "photo-take-photo",
                action: { viewModel.takePhoto() },
                iconName: "camera",
                textColor: .black,
                iconColor: .black
            )
            
            CustomButtonProfileImage(
                title: "photo-select-photo",
                action: { viewModel.selectPhoto() },
                iconName: "photo",
                textColor: .black,
                iconColor: .black
            )
            
            CustomButtonProfileImage(
                title: "photo-delete-photo",
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
