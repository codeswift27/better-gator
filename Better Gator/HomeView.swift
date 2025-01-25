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
    @Environment(\.managedObjectContext) private var viewContext
    @State var currentMood: Emotion? = nil
    var body: some View {
        NavigationView {
            VStack {
                Text("How are you feeling?")
                    .font(.headline)
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(Color(UIColor.secondarySystemBackground))
                            .frame(height: 100)
                            .cornerRadius(10)
                            .padding()
                        HStack {
                            Image("excited")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .onTapGesture {
                                    currentMood = .angry
                                }
                            Image("happy")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .onTapGesture {
                                    currentMood = .sad
                                }
                            Image("calm")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .onTapGesture {
                                    currentMood = .calm
                                }
                            Image("sad")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .onTapGesture {
                                    currentMood = .happy
                                }
                            Image("angry")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .onTapGesture {
                                    currentMood = .excited
                                }
                        }
                        .padding()
                    }
                }
                Button(action: {
                    guard let currentMood = currentMood else { return }
                    let newMood = Mood(context: viewContext)
                    newMood.emotion = Int32(currentMood.rawValue)
                    newMood.timestamp = Date()
                    do {
                        try viewContext.save()
                    } catch {
                        print("error!!")
                    }
                }) {
                    Text("Log emotion")
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Hello, Name")
        }
    }
}

#Preview {
    HomeView()
}
