//
//  ScrollViewOffsetPreferenceKey.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 24/7/24.
//

import Foundation
import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = 0
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    func onReachBottom(perform action: @escaping () -> Void) -> some View {
        self.background(
            GeometryReader { proxy in
                Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: proxy.frame(in: .named("scroll")).maxY)
            }
        )
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { maxY in
            if maxY == UIScreen.main.bounds.height {
                action()
            }
        }
    }
}
