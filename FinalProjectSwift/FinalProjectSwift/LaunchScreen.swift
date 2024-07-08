//
//  LaunchScreen.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 5/7/24.
//

import SwiftUI
import DotLottie

struct LaunchScreen: View {
    var body: some View {
        Text("Hola")
        DotLottieAnimation(fileName: "main_splash", config: AnimationConfig(autoplay: true, loop: true)).view()
    }
}

#Preview {
    LaunchScreen()
}
