//
//  ScrollViewHelper.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 27/7/24.
//

import Foundation
import SwiftUI

class ScrollViewHelper: ObservableObject {
    @Published var contentOffset: CGPoint = .zero
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = [CGPoint]
    static var defaultValue: [CGPoint] = []
    
    static func reduce(value: inout [CGPoint], nextValue: () -> [CGPoint]) {
        value.append(contentsOf: nextValue())
    }
}

struct ScrollViewOffsetView<Content: View>: View {
    @Binding var contentOffset: CGPoint
    let content: Content
    
    init(contentOffset: Binding<CGPoint>, @ViewBuilder content: () -> Content) {
        self._contentOffset = contentOffset
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            content
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: [geometry.frame(in: .named("scrollView")).origin])
                })
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            if let offset = value.last {
                DispatchQueue.main.async {
                    self.contentOffset = offset
                }
            }
        }
    }
}

struct ScrollViewHelperView: UIViewRepresentable {
    @Binding var contentOffset: CGPoint
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollViewHelperView
        
        init(_ parent: ScrollViewHelperView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async {
                self.parent.contentOffset = scrollView.contentOffset
            }
        }
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
}
