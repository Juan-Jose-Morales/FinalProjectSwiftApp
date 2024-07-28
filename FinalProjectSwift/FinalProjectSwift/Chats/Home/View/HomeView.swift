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
    @State private var isNavigationToChatView = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack (spacing: 0) {
                    CustomToolbar(
                        isShowingChangeProfileView: $isShowingChangeProfileView,
                        isShowingProfileSettingsView: $isShowingProfileSettingsView,
                        homeViewModel: homeViewModel
                    )
                    SearcField(imageName: "magnifyingglass", placeholder: "Buscar", text: $homeViewModel.search)
                        .onChange(of: homeViewModel.search) { newValue in
                            homeViewModel.chatFilter()
                        }
                        .padding(.top, 0)
                    if homeViewModel.listChats.isEmpty {
                        CustomListChat()
                    } else {
                        List {
                            ForEach(homeViewModel.filterChats) { chat in
                                NavigationLink(destination: ChatView(chatViewModel: ChatViewModel(chatId: chat.chat, chatList: chat))) {
                                    VStack {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(Color.white)
                                                    .shadow(radius: 5, x: 5, y: 5)
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                HStack{
                                                    ZStack {
                                                        Circle()
                                                            .foregroundColor(homeViewModel.color(for: chat.id))
                                                            .frame(width: 40, height: 40)
                                                        
                                                        Text(homeViewModel.capitalizedName(name: homeViewModel.getNick(chatList: chat)))
                                                            .foregroundStyle(.white)
                                                    }.padding(.horizontal, 8)
                                                    Text(homeViewModel.nameComprobation(user: chat))
                                                    Spacer()
                                                }.padding(.vertical, 1)
                                            }.padding(.vertical, 5)
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
                .onAppear {
                    homeViewModel.getChatlist()
                    UINavigationBar.appearance().backgroundColor = UIColor(named: "Blue")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                FloatButton(onUpdate: {
                    homeViewModel.getChatlist()
                })
            }
            .ignoresSafeArea(.keyboard, edges: .all)
            .navigationDestination(isPresented: $isShowingChangeProfileView) {
                ChangeProfileView(origin: .home)
            }
            .navigationDestination(isPresented: $isShowingProfileSettingsView) {
                ProfileSettingsView()
            }
            .navigationBarBackButtonHidden(true)
            .modifier(NavBarModifier())
        }
    }
}

#Preview {
    HomeView()
}

