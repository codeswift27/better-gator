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

    @Binding var currentMood: Emotion?
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
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
                        Text("Log Emotion")
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                    VStack {
                        Text(currentQuote.isEmpty ? "Tap the button for a quote!" : currentQuote)
                            .font(.subheadline)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.green)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button(action: {
                            currentQuote = quotes.randomElement() ?? "Keep pushing forward!"
                        }) {
                            Text("Get a Quote")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.accentColor)
                                .foregroundColor(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                }
            }
            .navigationTitle(greetingTime)
        }
    }
}

#Preview {
    HomeView(currentMood: .constant(.calm))
}

