//
//  FinalOnboardingPageView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 29/7/24.
//

import Foundation
import SwiftUI

struct FinalOnboardingPageView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image("appLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.bottom, 30)
                Text("Es hora de comenzar")
                    .font(.largeTitle)
                    .foregroundColor(Color("Blue"))
                    .padding()
                Text("¡Gracias por elegir EasyChat! Presiona el botón a continuación para empezar a usar la aplicación y comunicarte con tus amigos.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                Spacer()
                NavigationLink(destination: LoginView()) {
                    Text("Empezar")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("Blue"))
                        .cornerRadius(10)
                        
                }
                .padding(.top,20)
                .padding(.bottom, 50)
            }
            .padding(.horizontal)
        }
    }
}
