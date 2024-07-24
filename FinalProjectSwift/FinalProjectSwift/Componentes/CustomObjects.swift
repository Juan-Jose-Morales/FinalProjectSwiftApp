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


struct CustomNavigationBar: View {
    var title: String
    var titleColor: Color
    var buttonColor: Color
    var onBack: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                onBack()
            }) {
                Image("ArrowLeft")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(buttonColor)
            }
            Spacer()
            Text(title)
                .font(.headline)
                .foregroundColor(titleColor)
            Spacer()
           
        }
        .padding()
    }
}
