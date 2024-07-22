//
//  HomeView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 5/7/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @State private var isShowingChangeProfileView = false
    @State private var isShowingProfileSettingsView = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    SearcField(imageName: "magnifyingglass", placeholder: "", text: $homeViewModel.search)
                        .onChange(of: homeViewModel.search) { newValue in
                            homeViewModel.chatFilter()
                        }
                        .padding(.top, 20)
                    
                    if homeViewModel.listChats.isEmpty {
                        CustomListChat()
                    } else {
                        List {
                            ForEach(homeViewModel.listChats) { chat in
                                VStack {
                                    HStack {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        Text(chat.targetnick ?? "Usuario Desconocido")
                                    }
                                }
                            }
                            .onDelete(perform: { indexSet in
                                homeViewModel.deleteItems(at: indexSet)
                            })
                            .listRowSeparator(.hidden)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    Button(action: {
                        isShowingChangeProfileView = true
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .frame(width: 35, height: 35)
                            .padding(.top, 40)
                    }
                    .navigationDestination(isPresented: $isShowingChangeProfileView) {
                        ChangeProfileView(origin: .home)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingProfileSettingsView = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .frame(width: 35, height: 35)
                            .padding(.top, 40)
                    }
                    .navigationDestination(isPresented: $isShowingProfileSettingsView) {
                        ProfileSettingsView()
                    }
                }
            }
            .modifier(NavBarModifier())
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
