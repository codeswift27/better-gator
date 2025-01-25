//
//  JournalView.swift
//  Better Gator
//
//  Created by Foege, Erin M. on 1/25/25.
//

import SwiftUI

struct JournalView: View {
    @Environment(\.managedObjectContext) private var journal
    @State private var currentMood: Emotion = .angry
    @State private var journalInput = ""
    @State private var moodInt = 0
    @State private var prompt = ""
    @FocusState private var focus: Bool
    
    var promptDict = [0: "When do you feel most inspired? Can you find that                                      inspiration more frequently than you already do?",
                              1: "Who are the people who make you happiest? How are your relationships with those people right now? Is there anything you want to do differently in those relationships?",
                              2: "What is one thing you want to add to your daily routine? What is one thing you want to take away from your daily routine?",
                              3: "What makes you feel the happiest, and how can you move toward that happiness right now?" ,
                              4: "Is there one thing you can forgive yourself for today? Write down what you want to say to yourself."]
    
    
    var body: some View {
        VStack {
            ZStack{
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(height: 750)
                    .cornerRadius(10)
                    .padding()
                VStack {
                    Text("Journal")
                        .font(.title)
                    Spacer()
                        
                }
                .frame(height: 600)
                
                ZStack{
                    Rectangle()
                        .fill(Color(UIColor.systemBackground))
                        .cornerRadius(10)
                        .frame(height: 400)
                        .padding()
                    
                    VStack {
                       
                        Text(prompt)
                            .font(.title)
                        TextField("Enter your response here",text:$journalInput, axis:.vertical)
                            .padding()
                            .onSubmit {
                                print($journalInput)
                                let newJournal = Journal(context: journal)
                                newJournal.content = journalInput
                                newJournal.timestamp = Date()
                                do{
                                    try journal.save()
                                }
                                catch{
                                    print("error")
                                }
                            }
                            .focused($focus)
                            .onAppear{
                                focus = true
                                prompt =  promptDict[currentMood.rawValue] ?? ""
                            }
                            .onChange(of: currentMood) { newValue in
                                                            prompt = promptDict[newValue.rawValue] ?? ""
                                                        }
                            
                        Spacer()
                        
                    }.frame(height:400)
                }
                
                    
            }
        }
    }
}

#Preview {
    JournalView()
}
