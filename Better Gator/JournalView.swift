//
//  JournalView.swift
//  Better Gator
//
//  Created by Foege, Erin M. on 1/25/25.
//

import SwiftUI

struct JournalView: View {
    
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
                        .frame(height:200)
                        .cornerRadius(10)
                        .padding()
                    
                    VStack {
                        Text("Prompt")
                            .font(.title)
                        Spacer()
                        
                        TextField("Enter your response here",text:$journalInput, axis:.vertical)
                            .padding()
                            .onSubmit {
                                print($journalInput)
                            }
                            .focused($focus)
                            .onAppear{
                                focus = true
                    
                            }
                        
                            
                        
                            
                        
                        
                    }.frame(height:200)
                }
                
                    
            }
        }
    }
}

#Preview {
    JournalView()
}
