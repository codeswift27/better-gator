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
                        Circle()
                            .frame(height: 50)
                            .onTapGesture {
                                print("hi")
                            }
                        Circle()
                            .frame(height: 50)
                        Circle()
                            .frame(height: 50)
                        Circle()
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
