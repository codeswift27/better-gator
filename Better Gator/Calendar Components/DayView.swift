//
//  DayView.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/26/25.
//

import SwiftUI

struct DayView: View {
    var day: Day
    var moods: [Emotion]
    
    init(day: Day, moods: [Mood]) {
        self.day = day
        self.moods = moods.map { Emotion(rawValue: Int($0.emotion)) ?? .calm }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if let date = day.date {
                ZStack {
                    Text("\(date.day())")
                        .font(.system(size: 18))
                        .fontWeight(
                            date.isToday() ? Font.Weight.bold : Font.Weight.regular
                        )
                        .foregroundStyle(date.isToday() ? Color(UIColor.systemBackground) : Color.primary)
                }
                .frame(width: 24, height: 24)
                .background {
                    Circle()
                        .fill(date.isToday() ? Color.red : Color.white )
                        .frame(width: 36, height: 36, alignment: .center)
                }
                VStack(spacing: 4) {
                    if moods.contains(.excited) {
                        Rectangle()
                            .fill(Color.orange)
                            .cornerRadius(10)
                            .frame(width: 36, height: 6)
                    }
                    if moods.contains(.happy) {
                        Rectangle()
                            .fill(Color.yellow)
                            .cornerRadius(10)
                            .frame(width: 36, height: 6)
                    }
                    if moods.contains(.calm) {
                        Rectangle()
                            .fill(Color.purple)
                            .cornerRadius(10)
                            .frame(width: 36, height: 6)
                    }
                    if moods.contains(.nervous) {
                        Rectangle()
                            .fill(Color.green)
                            .cornerRadius(10)
                            .frame(width: 36, height: 6)
                    }
                    if moods.contains(.sad) {
                        Rectangle()
                            .fill(Color.blue)
                            .cornerRadius(10)
                            .frame(width: 36, height: 6)
                    }
                    if moods.contains(.angry) {
                        Rectangle()
                            .fill(Color.red)
                            .cornerRadius(10)
                            .frame(width: 36, height: 6)
                    }
                    Spacer()
                }
                .frame(height: 56)
            }
        }
    }
}

//#Preview {
//    DayView()
//}
