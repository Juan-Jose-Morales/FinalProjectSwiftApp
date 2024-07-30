//
//  OnboardingPageView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 29/7/24.
//

import Foundation
import SwiftUI

struct OnboardingPageView: View {
    var imageName: String
    var title: LocalizedStringKey
    var description: LocalizedStringKey

    var body: some View {
        ScrollView {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.bottom, 30)
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(Color("Blue"))
                    .padding(.bottom, 20)
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
