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
    @State private var prompt = ""
    @State private var response: LocalizedStringKey = " "
    @State private var isLoading = false
    @State private var hasSubmitted = false
    @FocusState private var focus: Bool

    var promptDict: [Int: String] = [
        0: "When do you feel most inspired? Can you find that inspiration more frequently?",
        1: "Who are the people who make you happiest? ...",
        2: "What is one thing you want to add to your daily routine? ...",
        3: "What am I afraid of and how is it limiting me?",
        4: "What makes you feel the happiest, ...",
        5: "Is there one thing you can forgive yourself for today? ..."
    ]

    func generateResponse() async {
        isLoading = true
        do {
            let result = try await model.generateContent(journalInput)
            response = LocalizedStringKey(result.text ?? "No response found")
        } catch {
            response = LocalizedStringKey("Something went wrong! \n\(error.localizedDescription)")
        }
        isLoading = false
        journalInput = ""
        hasSubmitted = false // Reset submission state after processing
    }

    var body: some View {
        VStack {
            Text("Journal")
                .font(.title)
                .padding()

            ZStack {
                Rectangle()
                    .fill(Color.accentColor)
                    .cornerRadius(10)
                    .padding()

                VStack {
                    Text(prompt)
                        .font(.headline)
                        .padding()

                    TextField("Enter your journal entry here", text: $journalInput, axis: .vertical)
                        .padding()
                        .focused($focus)
                        .onSubmit {
                            hasSubmitted = true // Mark as submitted
                            focus = false // Dismiss keyboard
                        }

                    Spacer()

                    if hasSubmitted {
                        if isLoading {
                            ProgressView() // Show loading indicator
                        } else {
                            Text(response)
                                .font(.body)
                                .padding()
                        }
                    }
                }
                .padding()
            }
            .onAppear { prompt = promptDict[currentMood.rawValue] ?? "" }
            .onChange(of: currentMood) { _, newValue in
                prompt = promptDict[newValue.rawValue] ?? ""
            }
            .task {
                if hasSubmitted {
                    await generateResponse()
                }
            }
        }
    }
}

#Preview {
    JournalView()
}
