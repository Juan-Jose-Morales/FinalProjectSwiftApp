//
//  KeyboardResponder.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 19/7/24.
//

import Foundation
import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .sink { [weak self] notification in
                guard let self = self,
                      let info = notification.userInfo,
                      let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                let keyboardHeight = keyboardFrame.height
                self.currentHeight = keyboardHeight
            }
    }
}

extension UIApplication {
    func endEditing() {
        windows.forEach { $0.endEditing(true) }
    }
}
