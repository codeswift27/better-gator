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
    @State private var currentQuote: String = ""

    let quotes = ["Keep your face always toward the sunshine, and shadows will fall behind you.",
                   "Go confidently in the direction of your dreams. Live the life you have imagined.",
                   "A person who never made a mistake never tried anything new.",
                   "Great works are performed not by strength, but perseverance.",
                   "Where there is love, there is life.",
                   "All our dreams can come true, if we have the courage to pursue them."]
    
    private var greetingTime: String {

        let hour = Calendar.current.component(.hour, from: Date())

        if hour < 12 {

            return "Good morning"

        } else if hour >= 12 && hour < 18 {

            return "Good afternoon"

        } else {

            return "Good evening"

        }

    }
    var body: some View {
        NavigationView {
            VStack {
                Text("\(greetingTime)!")

                    .font(.largeTitle)

                    .fontWeight(.bold)

                    .padding(.top)
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

                VStack {
                    Text(currentQuote.isEmpty ? "Tap the button for a quote!" : currentQuote)
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        currentQuote = quotes.randomElement() ?? "Keep pushing forward!"
                    }) {
                        Text("Get a Quote")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
            
            .navigationTitle(greetingTime)
        }
    }
}

#Preview {
    HomeView()
}
