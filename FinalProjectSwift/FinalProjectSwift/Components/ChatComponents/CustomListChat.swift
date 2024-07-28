//
//  CustomListChat.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 8/7/24.
//

import SwiftUI

struct CustomListChat: View {
    var body: some View {
        VStack {
            Image(.iconoChatList)
                .resizable()
                .frame(width: 160, height: 160)
                .padding(10)
            Text("Empieza un nuevo chat")
                .foregroundColor(.black)
                .bold()
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CustomListChat()
}
