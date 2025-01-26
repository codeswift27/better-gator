//
//  MonthView.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/26/25.
//

import SwiftUI

struct MonthView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\Mood.timestamp)])
    private var moodLog: FetchedResults<Mood>
    var month: Month
    @State var leadingPadding: CGFloat?

    var body: some View {
        var coordinateSpaceName: String = "monthViewVStack"
        let firstDayOfMonth = month.firstDayOfMonth
        let startingSpaces = firstDayOfMonth.isWeekDay()

        let isCurrentMonth = firstDayOfMonth.isCurrentMonth()

        VStack(
            alignment: .center,
            spacing: 10
        ) {
            
            // month label
            Text("\(firstDayOfMonth.monthString())")
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20))
                .fontWeight(
                    Font.Weight.bold
                )
                .foregroundStyle(
                    isCurrentMonth ? Color.red : Color.black
                )
                .padding(.leading, leadingPadding ?? 0 + 5)
                .foregroundStyle(Color.red)

            // days
            ForEach(0..<month.numberOfRows(), id: \.self) { row in
                HStack(
                    alignment: .center
                ) {
                    Spacer()
                        .frame(width: 10, height: 10, alignment: .center)
                    
                    ForEach(0..<7) { column in
                        let dayIndex = column + (row * 7)
                        let day = month.days[dayIndex]
                        if let date = day.date {
                            var moods = moodLog.filter { $0.timestamp!.isSameDay(date: date) }
                            DayView(day: day, moods: moods)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .overlay(GeometryReader { geometry -> Color in
                                    if (dayIndex == startingSpaces) {
                                        DispatchQueue.main.async {
                                            leadingPadding  = geometry.frame(in: .named(coordinateSpaceName)).minX
                                        }
                                    }
                                    return Color.clear
                                })
                        }
                    }
                
                    Spacer()
                        .frame(width: 10, height: 10, alignment: .center)
                
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 20)
        .padding(.bottom, 20)
        .coordinateSpace(name: coordinateSpaceName)
    }
    
}

//#Preview {
//    MonthView()
//}
