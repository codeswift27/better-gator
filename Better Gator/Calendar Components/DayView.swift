//
//  DayView.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/26/25.
//

import SwiftUI

struct DayView: View {
    var day: Day
    
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
                    Rectangle()
                        .fill(day.moods.contains(.excited) ? Color.orange : .clear)
                        .cornerRadius(10)
                        .frame(width: 36, height: 6)
                    Rectangle()
                        .fill(day.moods.contains(.happy) ? Color.yellow : .clear)
                        .cornerRadius(10)
                        .frame(width: 36, height: 6)
                    Rectangle()
                        .fill(day.moods.contains(.calm) ? Color.purple : .clear)
                        .cornerRadius(10)
                        .frame(width: 36, height: 6)
                    Rectangle()
                        .fill(day.moods.contains(.nervous) ? Color.green : .clear)
                        .cornerRadius(10)
                        .frame(width: 36, height: 6)
                    Rectangle()
                        .fill(day.moods.contains(.sad) ? Color.blue : .clear)
                        .cornerRadius(10)
                        .frame(width: 36, height: 6)
                    Rectangle()
                        .fill(day.moods.contains(.angry) ? Color.red : .clear)
                        .cornerRadius(10)
                        .frame(width: 36, height: 6)
                }
            }
        }
    }
}

//#Preview {
//    DayView()
//}
