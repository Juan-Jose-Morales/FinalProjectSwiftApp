//
//  ChangeProfileViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import Foundation
import PhotosUI

class ChangeProfileViewModel: ObservableObject {
    @Published var profileImage: UIImage?
    @Published var showImagePicker: Bool = false
    @Published var showCamera: Bool = false
    @Published var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    private let userService = UserService()
    
    func takePhoto() {
        self.imagePickerSource = .camera
        self.showImagePicker = true
    }
    
    func selectPhoto() {
        self.imagePickerSource = .photoLibrary
        self.showImagePicker = true
    }
    
    func deletePhoto() {
        self.profileImage = nil
    }
    
    func updateProfilePhoto(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        let userId = ""
        userService.uploadProfilePhoto(userId: userId, imageData: imageData) {result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.profileImage = image
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.alertMessage = "Error al actualizar la foto de perfil: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }
    }
}
