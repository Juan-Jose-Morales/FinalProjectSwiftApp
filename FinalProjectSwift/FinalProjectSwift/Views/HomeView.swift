//
//  HomeView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 5/7/24.
//

import SwiftUI


struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottomTrailing){
                VStack{
                    SearcField(imageName:  "magnifyingglass", placeholder: "", text: $homeViewModel.search)
                        .onChange(of: homeViewModel.search) { newValue in
                            homeViewModel.chatFilter()
                        }
                    if homeViewModel.listChats.isEmpty{
                        CustomListChat()
                    }else {
                            List{
                                ForEach(homeViewModel.listChats) { chat in
                                   // NavigationLink(destination: ChatView(chat: chat)
                                    VStack{
                                        HStack{
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                            Text(chat.targetnick ?? "Usuario Desconocido")
                                        }
                                    }
                                }.onDelete(perform: { indexSet in
                                    homeViewModel.deleteItems(at: indexSet)
                                })
                                .listRowSeparator(.hidden)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .scrollContentBackground(.hidden)
                            
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
                        .padding(.top, 40)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 42, height: 42)
                        .padding(.top, 40)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 42, height: 42)
                        .padding(.top , 40)
                }
            }.modifier(NavBarModifier())
        }//.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
