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
        DotLottieAnimation(fileName: "Animation - 1719854339733", config: AnimationConfig(autoplay: true, loop: true)).view()
    }
}

#Preview {
    LaunchScreen()
}
