//
//  ChatHeaderView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 18/7/24.
//

import Foundation
import SwiftUI

struct ChatHeaderView: View {
    let chatlist: ChatList
    @StateObject private var viewModel = ChatHeaderViewModel()
    @State private var isShowingDetailProfileView = false
    
    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink(destination: HomeView()) {
                    Image("ArrowLeft")
                        .resizable()
                        .frame(width: 35, height: 25)
                        .foregroundColor(.black)
                }
                Spacer()
                VStack {
                    Text(viewModel.getNick(chatList: chatlist))
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(viewModel.isOnline ? "En línea" : "Desconectado")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                    isShowingDetailProfileView = true
                }) {
                    NavigationLink(destination: ChatDetailView(chatDetailModel: ChatDetailViewModel(name: viewModel.getNick(chatList: chatlist), id: chatlist.targetnick ?? "", color: viewModel.color(for: chatlist.id), capitalizedName: viewModel.capitalizedName(chatList: chatlist), chatId: chatlist.chat, chat: chatlist))){
                            ZStack{
                                Circle()
                                    .fill(viewModel.color(for: chatlist.id))
                                    .frame(width: 45, height: 45)
                                Text(viewModel.capitalizedName(chatList: chatlist))
                                    .foregroundStyle(.white)
                            }
                        }
                }
            }
            .padding()
            .background(Color("Blue"))
            .onAppear {
                viewModel.updateOnlineStatus(chatList: chatlist)
            }
        }
    }
}


#Preview("ChatHeaderView Preview") {
    let chatList = ChatList(id: UUID(), chat: "123", source: "1", sourceonline: true, target: "2", targetnick: "Pepe", targetonline: true)
    return ChatHeaderView(chatlist: chatList)
}
