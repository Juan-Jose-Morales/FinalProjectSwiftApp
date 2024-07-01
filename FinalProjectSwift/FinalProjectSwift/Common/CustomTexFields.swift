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
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
            } else {
                TextField(placeholder, text: $text)
                    .padding()
            }
        }
        .background(RoundedRectangle(cornerRadius: 15)
            .stroke(Color.black, lineWidth: 1)
            .shadow(color: .black.opacity(0.2), radius: 4,x: 0, y: 4))
        .padding(.horizontal, 16)
    }
}
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
struct SecureFields: View {
    var title: String
    @State var binding: Binding<String>
    @State var visible = false
    var imageName: String
    
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.black)
                .padding(.leading, 8)
            
            if self.visible{
                TextField(title, text: binding)
                
            }else{
                SecureField(title, text: binding)
                    .foregroundColor(Color.black)
            }
            
            Button(action: {
                self.visible.toggle()
            }) {
                Image(systemName: self.visible ? "eye.fill" : "eye.slash.fill")
                    .foregroundColor((self.visible == true) ? Color.blue : Color.secondary)
            }
            
        }
        .frame(height: 50)
            .padding(.horizontal, 16)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
                .shadow(color: .black.opacity(0.2), radius: 4,x: 0, y: 4))
                .padding(.horizontal, 16)
    }
}
struct byometricButton: View {
    var action: () -> Void
    var imageName: String
    var body: some View {
        
        Button(action: action) {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .padding(.leading, 8)
                Text("Inicia Sesion con Biometria")
            }                    
            .foregroundColor(.black)
                .frame(height: 20)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1)
                    .shadow(color: .black.opacity(0.2), radius: 4,x: 0, y: 4))
                .padding(.horizontal, 16)
        }
        .padding(.horizontal, 10)
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


