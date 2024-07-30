//
//  KeyboardDismissView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 24/7/24.
//

import Foundation
import SwiftUI

class KeyboardDismissView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGesture()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct DismissKeyboardGesture: UIViewRepresentable {
    func makeUIView(context: Context) -> KeyboardDismissView {
        return KeyboardDismissView()
    }

    func updateUIView(_ uiView: KeyboardDismissView, context: Context) {}
}

