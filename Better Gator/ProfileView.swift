//
//  ProfileView.swift
//  Better Gator
//
//  Created by Foege, Erin M. on 1/25/25.
//

import SwiftUI


struct ProfileView: View {
    @Binding var isPresented: Bool
    @State private var userName: String =  UserDefaults.standard.String(forKey: "Save") ?? "John Doe"
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Information")) {
                    HStack {
                        Text("Name:")
                            .fontWeight(.semibold)
                        TextField("Enter your name", text: $userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                Section {
                    Button(action: {
                        saveChanges()
                    }) {
                        HStack {
                            Spacer()
                            Text("Save Changes")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
//                Button(role: .destructive, action: { resetChanges() }) {
//                    Text("Reset Changes")
//                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Text("Cancel")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveChanges()
                        isPresented.toggle()
                    }) {
                        Text("Done")
                            .bold()
                    }
                }
            }
        }
    }
    
    // Function to simulate saving changes
    private func saveChanges() {
        UserDefaults.standard.set(userName, forKey: "Save")
        print("User name saved: \(userName)")
    }
}
