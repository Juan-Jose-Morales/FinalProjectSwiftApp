//
//  CustomButton.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 2/7/24.
//

import Foundation
import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            Text(title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15)
                    .fill(Color("Blue"))
                    .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 15))
            
            
        }
        .padding(.horizontal, 16)
    }
}

struct BiometricButton: View {
    var action: () -> Void
    var imageName: String

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .padding(.leading, 8)
                Text("Inicia Sesion con Biometria")
                    .foregroundColor(.black)
            }
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4))
            .padding(.horizontal, 16)
        }
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}
