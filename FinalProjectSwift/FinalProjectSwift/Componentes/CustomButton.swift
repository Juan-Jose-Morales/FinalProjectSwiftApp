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
                .frame(width: 300, height: 43)
                .background(RoundedRectangle(cornerRadius: 15)
                    .fill(Color("Blue"))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10))
        }
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
                    .padding(.leading, 15)
                Spacer()
            }
            .frame(width: 300, height: 43)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10))
        }
    }
}

