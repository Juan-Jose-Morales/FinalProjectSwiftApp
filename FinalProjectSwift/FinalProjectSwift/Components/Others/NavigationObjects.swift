//
//  NavigationObjects.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 28/7/24.
//

import Foundation
import SwiftUI

struct CustomToolbar: View {
    
    @Binding var isShowingChangeProfileView: Bool
    @Binding var isShowingProfileSettingsView: Bool
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                isShowingChangeProfileView = true
            }) {
                if let profileImage = homeViewModel.profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } else {
                    Image("defaultAvatar")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
            }
            .padding(.leading, 20)
            .padding(.top, 40)

            Spacer()

            Image("logoFinalGrande")
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.top, 40)
            
            Spacer()

            Button(action: {
                isShowingProfileSettingsView = true
            }) {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.black)
            }
            .padding(.trailing, 20)
            .padding(.top, 40)
        }
        .frame(height: 160)
        .background(Color("Blue"))
        .ignoresSafeArea(edges: .top)
        .padding(.top, 0)
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
