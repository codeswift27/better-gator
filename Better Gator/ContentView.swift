//
//  ContentView.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/25/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    @State var currentMood: Emotion? = nil

    var body: some View {
        TabView {
            HomeView(currentMood: $currentMood)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            MeditationView()
                .tabItem {
                    Label("Meditate", systemImage: "camera.macro")
                }
            JournalView(currentMood: $currentMood)
                .tabItem {
                    Label("Journal", systemImage: "book.closed.fill")
                }
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}
//    }


#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
