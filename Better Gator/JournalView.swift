//
//  JournalView.swift
//  Better Gator
//
//  Created by Foege, Erin M. on 1/25/25.
//

import SwiftUI

struct JournalView: View {
    @Environment(\.managedObjectContext) private var journal
    
    @State private var journalInput = ""
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack {
            ZStack{
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(height: 600)
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
                        Text("Prompt")
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
