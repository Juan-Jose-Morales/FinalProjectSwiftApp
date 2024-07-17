//
//  ChangeProfileView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import SwiftUI

struct ChangeProfileView: View {
    @ObservedObject var viewModel = ChangeProfileViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Foto de perfil")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding()
                
                if let profileImage = viewModel.profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 262, height: 284)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding()
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 262, height: 284)
                        .foregroundColor(.gray)
                        .padding()
                }
                
                Divider()
                    
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
        }
    }
}

#Preview {
    ChangeProfileView()
}
