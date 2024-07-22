//
//  ChatHeaderView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 18/7/24.
//

import SwiftUI

struct ChatHeaderView: View {
    let chatlist: ChatList
    
    var body: some View {
        HStack {
            Button(action: {
                
            }) {
                Image("ArrowLeft")
                    .resizable()
                    .frame(width: 35, height: 25)
                    .foregroundColor(.black)
            }
            Spacer()
            VStack {
                Text(chatlist.targetnick ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(chatlist.sourceonline == true ? "En línea" : "Desconectado")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action: {
                
            }) {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 45, height: 45)
            }
        }
        .padding()
        .background(Color("Blue"))
    }
}

#Preview("ChatHeaderView Preview") {
    let chatList = ChatList(id: UUID(), chat: "123", source: "1", sourceonline: true, target: "2", targetnick: "Pepe", targetonline: true)
    return ChatHeaderView(chatlist: chatList)
}
