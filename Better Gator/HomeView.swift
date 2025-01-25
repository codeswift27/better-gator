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
    @State var currentEmotion: Emotion? = nil
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
                        Image("excited")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .onTapGesture {
                                currentEmotion = .angry
                            }
                        Image("happy")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                            .onTapGesture {
                                currentEmotion = .sad
                            }
                        Image("calm")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                            .onTapGesture {
                                currentEmotion = .calm
                            }
                        Image("sad")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                            .onTapGesture {
                                currentEmotion = .happy
                            }
                        Image("angry")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                            .onTapGesture {
                                currentEmotion = .excited
                            }
                    }
                    .padding()
                }
            }
            Button(action: {
                guard let currentEmotion = currentEmotion else { return }
                let newMood = Mood(context: viewContext)
                newMood.emotion = Int32(currentEmotion.rawValue)
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
    }
}

#Preview {
    HomeView()
}
