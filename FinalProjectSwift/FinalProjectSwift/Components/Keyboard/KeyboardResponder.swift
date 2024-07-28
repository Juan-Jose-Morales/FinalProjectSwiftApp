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
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification))
            .sink { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.currentHeight = keyboardFrame.height
                }
            }
            .store(in: &cancellableSet)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { _ in
                self.currentHeight = 0
            }
            .store(in: &cancellableSet)
    }
}
