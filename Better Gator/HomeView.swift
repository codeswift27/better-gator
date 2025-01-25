//
//  HomeView.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/25/25.
//

import SwiftUI

enum Emotion: Int {
    case excited = 0
    case happy = 1
    case calm = 2
    case sad = 3
    case angry = 4
}

struct HomeView: View {
    @State var emotion: Emotion? = nil
    var body: some View {
        VStack {
            Text("How are you feeling?")
                .font(.title)
            HStack {
//                if true {
//                    TextField($emotion)
//                } else {
//
//                }
                ZStack {
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(height: 100)
                        .cornerRadius(10)
                        .padding()
                    HStack(spacing: 20) {
                        Circle()
                            .frame(height: 50)
                            .onTapGesture {
                                emotion = .angry
                            }
                        Circle()
                            .frame(height: 50)
                            .onTapGesture {
                                emotion = .sad
                            }
                        Circle()
                            .frame(height: 50)
                            .onTapGesture {
                                emotion = .calm
                            }
                        Circle()
                            .frame(height: 50)
                            .onTapGesture {
                                emotion = .happy
                            }
                        Circle()
                            .frame(height: 50)
                            .onTapGesture {
                                emotion = .excited
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
