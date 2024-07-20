//
//  LaunchScreen.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 5/7/24.
//

import SwiftUI
import DotLottie

struct LaunchScreen: View {
    @State private var showInitialView = true
    var body: some View {
        VStack {
            if showInitialView == true{
                DotLottieAnimation(fileName: "main_splash", config: AnimationConfig(autoplay: true, loop: true)).view()
            }else {
               LoginView()
            }
       
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showInitialView = false}}
    }
}

#Preview {
    LaunchScreen()
}
