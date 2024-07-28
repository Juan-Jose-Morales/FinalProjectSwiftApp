//
//  FinalProjectSwiftApp.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 25/6/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct FinalProjectSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var isActive = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LaunchScreen()
                    .environmentObject(SessionManager())
            }
        }
    }
}
