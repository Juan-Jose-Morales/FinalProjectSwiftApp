//
//  HomeView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 5/7/24.
//

import SwiftUI

struct HomeView: View {
    let chatList: [String] = []
    @State private var showingSheet = false
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottomTrailing){
                VStack{
                    if chatList.isEmpty{
                        CustomListChat()
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color("Blue"))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(35)
                .sheet(isPresented: $showingSheet) {
                    Text("Hola")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("logoFinalGrande")
                        .resizable()
                        .frame(width: 100, height: 75)
                        .padding()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        .padding()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        .padding()
                }
            }.modifier(NavBarModifier())
        }
    }
}

#Preview {
    HomeView()
}
