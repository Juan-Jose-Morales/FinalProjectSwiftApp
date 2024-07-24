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
                VStack (spacing: 0) {
                    CustomToolbar(
                        isShowingChangeProfileView: $isShowingChangeProfileView,
                        isShowingProfileSettingsView: $isShowingProfileSettingsView,
                        homeViewModel: homeViewModel
                    )
                    SearcField(imageName: "magnifyingglass", placeholder: "", text: $homeViewModel.search)
                        .onChange(of: homeViewModel.search) { newValue in
                            homeViewModel.chatFilter()
                        }
                        .padding(.top, 0)
                    
                    if homeViewModel.listChats.isEmpty {
            ZStack (alignment: .bottomTrailing){
                VStack{
                    SearcField(imageName:  "magnifyingglass", placeholder: "Buscar", text: $homeViewModel.search)
                    if homeViewModel.listChats.isEmpty{
                        CustomListChat()
                    } else {
                        List {
                            ForEach(homeViewModel.listChats) { chat in
                                NavigationLink(destination: ChatView(chatViewModel: ChatViewModel(chatId: chat.chat, chatList: chat))) {
                                    VStack {
                                        HStack {
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                            Text(homeViewModel.getNick(chatList: chat))
                                        }
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
                }.onAppear(){
                    homeViewModel.getChatlist()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                FloatButton(onUpdate: {
                    homeViewModel.getChatlist()
                })
            }
            .navigationDestination(isPresented: $isShowingChangeProfileView) {
                ChangeProfileView(origin: .home)
            }
            .navigationDestination(isPresented: $isShowingProfileSettingsView) {
                ProfileSettingsView()
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
              UINavigationBar.appearance().backgroundColor = UIColor(named: "Blue")
            }
    }
}

#Preview {
    HomeView()
}
