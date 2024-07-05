//
//  FinalProjectSwiftApp.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 25/6/24.
//

import SwiftUI

@main
struct FinalProjectSwiftApp: App {
    
    @State private var isActive = false
    
    var body: some Scene {
        WindowGroup {
            
            VStack {
                if isActive {
                    LoginView()
                } else {
                    LaunchScreen()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
