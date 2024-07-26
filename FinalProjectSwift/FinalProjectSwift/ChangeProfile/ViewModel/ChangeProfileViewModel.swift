//
//  ChangeProfileViewModel.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 17/7/24.
//

import Foundation
import SwiftUI

class ChangeProfileViewModel: ObservableObject {
    @Published var profileImage: UIImage?
    @Published var showImagePicker: Bool = false
    @Published var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private let profileImageKey = "profileImageKey"
    
    init() {
        loadProfilePhoto()
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePickerSource = .camera
            self.showImagePicker = true
        } else {
            self.alertMessage = "La cámara no está disponible."
            self.showAlert = true
        }
    }
    
    func selectPhoto() {
        self.imagePickerSource = .photoLibrary
        self.showImagePicker = true
    }
    
    func deletePhoto() {
        self.profileImage = nil
        UserDefaults.standard.removeObject(forKey: profileImageKey)
    }
    
    func updateProfilePhoto(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        UserDefaults.standard.set(imageData, forKey: profileImageKey)
        self.profileImage = image
    }
    
    private func loadProfilePhoto() {
        if let imageData = UserDefaults.standard.data(forKey: profileImageKey),
           let image = UIImage(data: imageData) {
            self.profileImage = image
        }
    }
}
