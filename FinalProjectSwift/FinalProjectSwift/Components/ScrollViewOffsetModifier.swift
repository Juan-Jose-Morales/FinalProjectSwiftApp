//
//  ScrollViewOffsetModifier.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import SwiftUI

struct ScrollViewOffsetModifier: ViewModifier {
    @Binding var offset: CGPoint

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear.preference(key: ViewOffsetKey.self, value: geometry.frame(in: .named("scrollView")).origin)
            })
            .onPreferenceChange(ViewOffsetKey.self) { value in
                self.offset = value
            }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

extension View {
    func offsetCapture(_ offset: Binding<CGPoint>) -> some View {
        self.modifier(ScrollViewOffsetModifier(offset: offset))
    }
}
