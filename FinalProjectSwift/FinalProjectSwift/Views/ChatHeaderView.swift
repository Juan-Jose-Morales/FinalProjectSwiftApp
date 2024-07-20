//
//  ChatHeaderView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 18/7/24.
//

import SwiftUI

struct ChatHeaderView: View {
    let user: User
    let profileImage: UIImage?
    
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
                Text(user.nick ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(user.online == true ? "En línea" : "Desconectado")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action: {
                
            }) {
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 45, height: 45)
                }
            }
        }
        .padding()
        .background(Color("Blue"))
    }
}

#Preview("ChatHeaderView Preview") {
    let user = User(id: "1", login: "user1", password: "password", nick: "Juan", avatar: nil, platform: nil, uuid: nil, online: true, created: nil, updated: nil, token: nil)
    let profileImage = UIImage(systemName: "person.fill") 
    
    return ChatHeaderView(user: user, profileImage: profileImage)
}
