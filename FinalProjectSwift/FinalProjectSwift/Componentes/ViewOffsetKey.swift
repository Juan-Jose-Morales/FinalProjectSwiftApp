//
//  ViewOffsetKey.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}
