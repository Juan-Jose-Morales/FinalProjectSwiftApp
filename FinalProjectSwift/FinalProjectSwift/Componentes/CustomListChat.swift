//
//  CustomListChat.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 8/7/24.
//

import SwiftUI

struct CustomListChat: View {
    var body: some View {
        VStack{
            
            Image(.iconoChatList)
            Text("Empieza un nuevo chat")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CustomListChat()
}
