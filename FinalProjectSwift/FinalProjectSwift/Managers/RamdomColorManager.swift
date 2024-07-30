//
//  RamdomColorManager.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 27/7/24.
//

import Foundation
import SwiftUI

class RandomColorManager: ObservableObject {
    static let shared = RandomColorManager()
    
    private init() {}
    
    private var colors: [UUID: Color] = [:]
    
    func color(for chatId: UUID) -> Color {
        if let color = colors[chatId] {
            return color
        } else {
            let newColor = generateRandomColor()
            colors[chatId] = newColor
            return newColor
        }
    }
    
    private func generateRandomColor() -> Color {
        var red: Double
        var green: Double
        var blue: Double
        
        repeat {
            red = Double.random(in: 0...1)
            green = Double.random(in: 0...1)
            blue = Double.random(in: 0...1)
        } while (red > 0.9 && green > 0.9 && blue > 0.9)
        
        return Color(red: red, green: green, blue: blue)
    }
}
