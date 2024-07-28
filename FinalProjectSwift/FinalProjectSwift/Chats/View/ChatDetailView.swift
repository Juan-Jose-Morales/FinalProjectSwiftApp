//
//  ChatDetailView.swift
//  FinalProjectSwift
//
//  Created by Alejandro Vidal Gómez Alves on 28/7/24.
//

import SwiftUI


struct ChatDetailView: View {
    @StateObject var chatDetailModel: ChatDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    Color("Blue")
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 310)
                    
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(chatDetailModel.color)
                                .frame(width: 170, height: 170)
                            
                            Text(chatDetailModel.capitalizedName(name: chatDetailModel.name))
                                .bold()
                                .foregroundColor(.white)
                                .font(.system(size: 170))
                        }
                        .padding(16)
                        
                        VStack {
                            Text(chatDetailModel.name)
                                .bold()
                                .foregroundColor(.white)
                                .font(.title)
                            
                            Text(chatDetailModel.id)
                                .bold()
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    }
                }
                .padding(.bottom, 20)
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                        .frame(width: 20, height: 20)
                        .bold()
                        .padding(.leading, 20)
                    
                    Text("Fotos recientes")
                        .bold()
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.vertical, 8)
                
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                    ForEach(0..<9) { _ in
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 65, height: 65)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                    }
                }
                .padding()
                
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
            }
            .onAppear() {
                UINavigationBar.appearance().backgroundColor = UIColor(named: "Blue")
        }
        }
    }
}
#Preview {
    ChatDetailView(chatDetailModel: ChatDetailViewModel(name: "pepe", id: "345", color: .red))
}
