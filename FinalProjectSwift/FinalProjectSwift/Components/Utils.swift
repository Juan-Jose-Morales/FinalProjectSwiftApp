//
//  Utils.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 24/7/24.
//

import Foundation
import SwiftUI


enum Origin {
    case home
    case profile
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

enum Field {
        case username
        case password
    }
