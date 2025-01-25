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
                        Image("5")
                            .frame(height: 50)
                            .onTapGesture {
                            }
                        Image("2")
                            .frame(height: 50)
                        Image("1")
                            .frame(height: 50)
                        Image("3")
                            .frame(height: 50)
                        Image("4")
                            .frame(height: 50)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
