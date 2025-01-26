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
    @Binding var currentMood: Emotion?
    @State var showProfile: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showProfile.toggle()
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 28)
            
                        }
                        .sheet(isPresented: $showProfile) {
                            ProfileView(isPresented: $showProfile)
                        }
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
                                    .background(currentMood == .excited ? Color.accentColor.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        currentMood = .excited
                                    }
                                Image("happy")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .background(currentMood == .happy ? Color.accentColor.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        currentMood = .happy
                                    }
                            }
                            HStack {
                                Image("calm")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .background(currentMood == .calm ? Color.accentColor.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        currentMood = .calm
                                    }
                                Image("nervous")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .background(currentMood == .nervous ? Color.accentColor.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        currentMood = .nervous
                                    }
                            }
                            HStack {
                                Image("sad")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .background(currentMood == .sad ? Color.accentColor.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        currentMood = .sad
                                    }
                                Image("angry")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .background(currentMood == .angry ? Color.accentColor.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        currentMood = .angry
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
            }
            .navigationTitle("Hello, Name")
        }
    }
}

#Preview {
    HomeView(currentMood: .constant(.calm))
}
