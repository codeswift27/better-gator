//
//  Month.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/26/25.
//

import Foundation
import SwiftUI

class Month: Identifiable, Equatable {
    static func == (lhs: Month, rhs: Month) -> Bool{
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var firstDayOfMonth: Date
    var days: Array<Day>
    
    init(firstDayOfMonth: Date, events: FetchedResults<Mood>) {
        let daysInMonth = firstDayOfMonth.daysInMonth()
        
        let startingSpaces = firstDayOfMonth.isWeekDay()
        var days = Array(repeating: Day(date: nil), count: startingSpaces)

        var date = firstDayOfMonth
        var moods = events.filter { $0.timestamp.d }
        if events.contains(where: { $0.someProperty == "nameToMatch" })
        days.append(Day(date: date))
        for _ in 1..<daysInMonth {
            date = date.plusDate()
            days.append(Day(date: date))
        }
        

        let monthRowCount = Int(ceil((Double(daysInMonth + startingSpaces)/7)))
        let trailingSpaces = Array(repeating: Day(date: nil), count: monthRowCount * 7 - daysInMonth - startingSpaces)
        days.append(contentsOf: trailingSpaces)
        
        self.firstDayOfMonth = firstDayOfMonth
        self.days = days
    }
    
    
    func numberOfRows() -> Int {
        let daysInMonth = firstDayOfMonth.daysInMonth()
        let startingSpaces = firstDayOfMonth.isWeekDay()
        let monthRowCount = Int(ceil((Double(daysInMonth + startingSpaces)/7)))
        return monthRowCount
    }
}
