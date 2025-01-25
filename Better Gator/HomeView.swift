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
                ZStack {
                    Rectangle()
                        .fill(Color(UIColor.secondarySystemBackground))
                        .frame(height: 100)
                        .cornerRadius(10)
                        .padding()
                    HStack {
                        Image("5")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .onTapGesture {
                                emotion = .angry
                            }
                        Image("2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .onTapGesture {
                                emotion = .sad
                            }
                        Image("1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .onTapGesture {
                                emotion = .calm
                            }
                        Image("3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .onTapGesture {
                                emotion = .happy
                            }
                        Image("4")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .onTapGesture {
                                emotion = .excited
                            }
                    }
                }
            }
            Button(action: {}) {
                Text("Log emotion")
                    .foregroundStyle(Color.primary)
            }
            .background(Color.accentColor)
        }
    }
}

#Preview {
    HomeView()
}
