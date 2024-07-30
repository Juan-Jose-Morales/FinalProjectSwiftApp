//
//  OnboardingView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 29/7/24.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: LoginView()) {
                        Text("Skip")
                            .foregroundColor(Color("Blue"))
                            .padding()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal)
                
                Spacer()
                TabView(selection: $currentPage) {
                    OnboardingPageView(imageName: "appLogo", title: "onboarding_page_0_title", description: "onboarding_page_0_description")
                        .tag(0)
                    OnboardingPageView(imageName: "messages", title: "onboarding_page_1_title", description: "onboarding_page_1_description")
                        .tag(1)
                    OnboardingPageView(imageName: "conectado", title: "onboarding_page_2_title", description: "onboarding_page_2_description")
                        .tag(2)
                    OnboardingPageView(imageName: "eliminar", title: "onboarding_page_3_title", description: "onboarding_page_3_description")
                        .tag(3)
                    OnboardingPageView(imageName: "profileImage", title: "onboarding_page_4_title", description: "onboarding_page_4_description")
                        .tag(4)
                    FinalOnboardingPageView()
                        .tag(5)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 500)
                
                HStack(spacing: 8) {
                    ForEach(0..<6) { index in
                        Button(action: {
                            currentPage = index
                        }) {
                            Circle()
                                .fill(index == currentPage ? Color.blue : Color.gray)
                                .frame(width: 10, height: 10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 16)

                HStack {
                    Button(action: {
                        if currentPage > 0 {
                            currentPage -= 1
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color("Blue"))
                    }
                    .padding()

                    Spacer()

                    Button(action: {
                        if currentPage < 5 {
                            currentPage += 1
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color("Blue"))
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
