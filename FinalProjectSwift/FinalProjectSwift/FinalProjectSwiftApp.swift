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
            NavigationStack {
                LoginView()
                    .environmentObject(SessionManager())
            }
        }
    }
}
