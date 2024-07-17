//
//  HomeView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 5/7/24.
//

import SwiftUI

struct HomeView: View {
    let chatList: [String] = []
    @State private var hola = ""
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottomTrailing){
                VStack{
                    SearcField(imageName:  "magnifyingglass", placeholder: "", text: $hola)
                    if chatList.isEmpty{
                        CustomListChat()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                FloatButton()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("logoFinalGrande")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 35, height: 35)
                        .padding()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 35, height: 35)
                        .padding()
                }
            }.modifier(NavBarModifier())
        }
    }
}

#Preview {
    HomeView()
}
