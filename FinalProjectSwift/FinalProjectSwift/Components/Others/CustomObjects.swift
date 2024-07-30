//
//  CustomObjects.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 10/7/24.
//

import Foundation
import SwiftUI

struct CustomLogo: View {
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        VStack{
            Image("appLogo")
                .resizable()
                .frame(width: width, height: height)
                .padding(.top, 50)
                .scaledToFit()
        }
    }
}
