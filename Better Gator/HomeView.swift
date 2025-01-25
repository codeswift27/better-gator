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
    case nervous = 3
    case sad = 4
    case angry = 5
}

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var currentMood: Emotion? = nil
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
//                        .resizable()
//                        .frame(height: )
                }
                .padding()
                Text("How are you feeling?")
                    .font(.headline)
                HStack {
                    VStack {
                        HStack {
                            Image("excited")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
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
                        }
                        HStack {
                            Image("calm")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .onTapGesture {
                                    currentMood = .calm
                                }
                            Image("nervous")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .onTapGesture {
                                    currentMood = .nervous
                                }
                        }
                        HStack {
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
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
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
                Spacer()
            }
            .navigationTitle("Hello, Name")
        }
    }
}

#Preview {
    HomeView()
}
