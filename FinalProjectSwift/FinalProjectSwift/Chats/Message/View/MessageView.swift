//
//  MessageView.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 24/7/24.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    let isCurrentUser: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isCurrentUser {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(message.message)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(22)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                        Text(getTime(from: message.date))
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text(message.message)
                            .padding()
                            .background(Color("Blue"))
                            .cornerRadius(22)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        Text(getTime(from: message.date))
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
            }
            .padding(.top, 5)
        }
    }
}

#Preview {
    MessageView(
        message: Message(id: "1", chat: "1", source: "user1", message: "Test message", date: "2024-07-22T16:03:44.798Z"),
        isCurrentUser: true
    )
}
