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
        let sizeHeight: CGFloat = 55
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(resource: .blue)
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        let navigationBar = UINavigationBar()
        
        navigationBar.sizeToFit()
//        navigationBar.frame.size.height(sizeHeight)
    }

    func body(content: Content) -> some View {
        content
    }
}