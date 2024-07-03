//
//  CustomTexFields.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 1/7/24.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    var imageName: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.black)
                .padding(.leading, 8)

                TextField(placeholder, text: $text)
                    .padding()
            
        }
        .frame(width: 300, height: 43)
        .background(RoundedRectangle(cornerRadius: 15)
            .stroke(Color.black, lineWidth: 1)
            .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 15))
    }
}
struct SecureFields: View {
    var title: String
    @Binding var text: String
    @State private var visible = false
    var imageName: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.black)
                .padding(.leading, 8)

            if self.visible {
                TextField(title, text: $text)
                    .padding()
            } else {
                SecureField(title, text: $text)
                    .padding()
            }

            Button(action: {
                self.visible.toggle()
            }) {
                Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                    .foregroundColor((self.visible == true) ? .blue : .secondary)
                    .padding(.horizontal, 8)
            }
        }
        .frame(width: 300, height: 43)
        .background(RoundedRectangle(cornerRadius: 15)
            .stroke(Color.black, lineWidth: 1)
            .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 15))
    }
}
struct CustomLogo: View {
    var widht: CGFloat
    var height: CGFloat
    var body: some View {
        VStack{
            Image("appLogo")
                .resizable()
                .frame(width: widht, height: height)
                .padding(.top, 50)
                .scaledToFit()
        }
    }
}

