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
    @Binding var currentMood: Emotion?
    @State private var journalInput = ""
    @State private var prompt = ""
    @State private var response: LocalizedStringKey = " "
    @State private var isLoading = false
    @FocusState private var focus: Bool

    var promptDict: [Int: String] = [
                              0: "When do you feel most inspired? Can you find that inspiration more frequently than you already do?",
                              1: "Who are the people who make you happiest? How are your relationships with those people right now? Is there anything you want to do differently in those relationships?",
                              2: "What is one thing you want to add to your daily routine? What is one thing you want to take away from your daily routine?",
                              3: "What am I afraid of and how is it limiting me?",
                              4: "What makes you feel the happiest, and how can you move toward that happiness right now?" ,
                              5: "Is there one thing you can forgive yourself for today? Write down what you want to say to yourself."
    ]

    func generateResponse() async {
        isLoading = true
        defer { isLoading = false } // Ensure loading is stopped even if an error occurs
        do {
            let result = try await model.generateContent(journalInput)
            response = LocalizedStringKey(result.text ?? "No response found")
        } catch {
            response = LocalizedStringKey("Something went wrong! \n\(error.localizedDescription)")
        }
    }

    var body: some View {
        VStack {
            Text("Journal")
                .font(.title)
                .padding()

            ZStack {
                Rectangle()
                    .fill(Color.accentColor)
                    .opacity(0.5)
                    .cornerRadius(10)
                    .padding()

                VStack {
                    Text(prompt)
                        .font(.headline)
                        .padding()

                    TextField("Enter your journal entry here", text: Binding(
                        get: { journalInput },
                        set:
                            { (newValue, _) in
                                if let _ = newValue.lastIndex(of: "\n") {
                                    focus = false
                                } else {
                                    journalInput = newValue
                                }
                            }
                      ), axis: .vertical)
                        .padding()
                        .submitLabel(.done)
                        .focused($focus)
                        .onChange(of: focus) {
                            guard !journalInput.isEmpty else { return }
                            print("Submitting")
                            Task {
                                await generateResponse()
                            }
                        }

                    Spacer()

                    if isLoading {
                        ProgressView()
                            .padding()
                    } else if response != "" {
                        Text(response)
                            .font(.body)
                            .padding()
                    }
                }
                .padding()
            }
            .onAppear { prompt = promptDict[currentMood?.rawValue ?? 2] ?? "" }
            .onChange(of: currentMood ?? Emotion.calm) { _, newValue in
                prompt = promptDict[newValue.rawValue] ?? ""
            }
        }
    }
}

#Preview {
    JournalView(currentMood: .constant(.calm))
}
