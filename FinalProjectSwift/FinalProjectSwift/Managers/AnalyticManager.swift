//
//  AnalyticManager.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 29/7/24.
//

import Foundation
import FirebaseAnalytics
import SwiftUI
import Firebase

final class AnalyticManager {
    private init() {
        FirebaseApp.configure()
    }
    
    static let shared = AnalyticManager()
    public func logEvent(_ event: AnalyticsEvent) {
        
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: String(describing: type(of: self)),
            AnalyticsParameterScreenClass: String(describing: type(of: self))
            ]
        )
    }
    enum AnalyticsEvent {
        case navigation(NavigationScreenEvent)
        
        var event : String {
            switch self {
            case .navigation: return "Navigation"
            }
        }
    }
}

struct NavigationScreenEvent: Codable {
    let nameScreen: String
    let timeStamp: Date
}
