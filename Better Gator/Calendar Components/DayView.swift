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
                }
                .frame(width: 16, height: 16)
                .font(.system(size: 18))
                .fontWeight(
                    date.isToday() ? Font.Weight.bold : Font.Weight.regular
                )
                .foregroundStyle(Color.primary)
                .background(
                    Circle()
                        .fill(date.isToday() ? Color.red : Color.white )
                        .frame(width: 35, height: 35, alignment: .center)
                )
                if (day.hasEvent) {
                    Circle()
                        .fill(Color(UIColor.gray))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

//#Preview {
//    DayView()
//}
