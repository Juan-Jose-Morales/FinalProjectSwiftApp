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
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
                .padding(.leading, 8)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.default)
                .padding()
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 43)
        .background(RoundedRectangle(cornerRadius: 15)
            .stroke(Color.black, lineWidth: 1)
            .shadow(radius: 5))
    }
}

struct SecureFields: View {
    var title: String
    @Binding var text: String
    @State private var visible = false
    var imageName: String
    
    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .padding(.leading, 8)
                
                if self.visible {
                    TextField(title, text: $text)
                        .padding()
                        .textInputAutocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.asciiCapable)
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                } else {
                    SecureField(title, text: $text)
                        .padding()
                        .textInputAutocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.asciiCapable)
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                }
                
                Button(action: {
                    self.visible.toggle()
                }) {
                    Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(self.visible ? .blue : .secondary)
                        .padding(.horizontal, 8)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 43)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
                .shadow(radius: 5))
        }
        .background(DismissKeyboardGesture())
    }
}

struct SearcField: View {
    var imageName: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .padding(.leading, 8)
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .padding()
                } else {
                    TextField(placeholder, text: $text)
                        .padding()
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                }
            }
            .frame(height: 45)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
                .shadow(radius: 5))
            .padding(.top, 0)
            .padding(.horizontal, 20)
            
        }
    }
}
