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
                .frame(height: 43)
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
            .padding(.horizontal,20)
            .frame(maxWidth: .infinity)
            .frame(height: 43)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10))
        }
    }
}



struct FloatButton: View {
    @State private var showingSheet = false
    var body: some View {
        Button {
            showingSheet.toggle()
            
        } label: {
            Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .frame(width: 35, height: 35)
                .padding()
                .background(Color("Blue"))
                .foregroundColor(.white)
                .clipShape(Circle())
        }
        .padding(35)
        .sheet(isPresented: $showingSheet) {
            Text("Hola")
        }
    }
}


struct NavBarModifier: ViewModifier {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(resource: .blue)
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        let navigationBar = UINavigationBar()
        
        navigationBar.sizeToFit()
        //navigationBar.frame.size.height(sizeHeight)
    }
    
    func body(content: Content) -> some View {
        content
    }
}
struct CustomProfileButton: View {
    var title: String
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(iconName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                Spacer()
                Text(title)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(width: 305, height: 35)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color("Gray"), lineWidth: 1)
                .shadow(radius: 5))
        }
    }
}

struct CustomButtonProfileImage: View {
    var title: String
    var action: () -> Void
    var iconName: String
    var textColor: Color
    var iconColor: Color
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(textColor)
                    .font(.system(size: 18))
                Spacer()
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(iconColor)
            }
            .padding()
            .frame(width: 335, height: 41)
            .background(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10))
        }
    }
}
