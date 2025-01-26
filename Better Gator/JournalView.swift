//
//  JournalView.swift
//  Better Gator
//
//  Created by Foege, Erin M. on 1/25/25.
//

import SwiftUI
import GoogleGenerativeAI
struct JournalView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @Environment(\.managedObjectContext) private var journal
    @State private var currentMood: Emotion = .happy
    @State private var journalInput = ""
    @State private var moodInt = 0
    @State private var prompt = ""
    @State var isLoading = false
    @FocusState private var focus: Bool
    @State private var hasSubmitted = false
    
    var promptDict = [0: "When do you feel most inspired? Can you find that                                      inspiration more frequently than you already do?",
                              1: "Who are the people who make you happiest? How are your relationships with those people right now? Is there anything you want to do differently in those relationships?",
                              2: "What is one thing you want to add to your daily routine? What is one thing you want to take away from your daily routine?",
                              3: "What am I afraid of and how is it limiting me?",
                              4: "What makes you feel the happiest, and how can you move toward that happiness right now?" ,
                              5: "Is there one thing you can forgive yourself for today? Write down what you want to say to yourself."]
    
    func generateResponse() async {
            isLoading = true
            @State var response: LocalizedStringKey = " "
            
            do {
                let result = try await model.generateContent(journalInput)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No response found")
                journalInput = ""
            } catch {
                response = "Something went wrong! \n\(error.localizedDescription)"
            }
        }
    
    
    var body: some View {
        VStack {
            ZStack{
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(height: 700)
                    .cornerRadius(10)
                    .padding()
                VStack {
                    Text("Journal")
                        .font(.title)
                    Spacer()
                        
                }
                .frame(height: 700)
                
                ZStack{
                    Rectangle()
                        .fill(Color(UIColor.systemBackground))
                        .cornerRadius(10)
                        .frame(height: 400)
                        .padding()
                    
                    VStack {
                       
                        Text(prompt)
                            .font(.title)
                        TextField("Enter your journal entry here",text:$journalInput, axis:.vertical)
                            .padding()
                            .onSubmit {
                                hasSubmitted = true
                            }
                            .focused($focus)
                            .onAppear{
                                focus = true
                                prompt =  promptDict[currentMood.rawValue] ?? ""
                            }
                            .onDisappear{
                                focus = false
                            }
                            .onChange(of: currentMood) { _, newValue in
                                prompt = promptDict[newValue.rawValue] ?? ""
                            }
                        
                        Spacer()
                        
                    }.frame(height:400)
                }
                
                    
            }
            .task {
                if hasSubmitted {
                    await generateResponse()
                    hasSubmitted = false
                }
            }
        }
    }
}

#Preview {
    JournalView()
}
