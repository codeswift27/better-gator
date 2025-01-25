//
//  HomeView.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/25/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("How are you feeling?")
                .font(.title)
            HStack {
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
