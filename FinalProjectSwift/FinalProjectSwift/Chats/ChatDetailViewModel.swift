//
//  ChatDetailViewModel.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 28/7/24.
//

import Foundation
import SwiftUI

class ChatDetailViewModel: ObservableObject {
    
    var name: String
    var id: String
    var color: Color
    
    init(name: String, id: String, color: Color){
        self.name = name
        self.id = id
        self.color = color
    }
    
    func capitalizedName(name: String) -> String {
        if name == "" {
            return "?"
        } else {
            return name.prefix(1).capitalized
        }
    }
}
