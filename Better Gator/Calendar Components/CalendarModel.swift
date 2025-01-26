//
//  CalendarModel.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/26/25.
//

import SwiftUI

class CalendarModel: ObservableObject {
    @Published var months: [Month]
    
    init() {
        let today = Date()
        let firstDayOfCurrentMonth = today.firstDayOfMonth()
        var firstDayOfMonth = firstDayOfCurrentMonth.minusMonth(5)
        
        var months: [Month] = [Month(firstDayOfMonth: firstDayOfMonth)]

        for _ in 0..<11 {
            firstDayOfMonth = firstDayOfMonth.plusMonth()
            months.append(Month(firstDayOfMonth: firstDayOfMonth))
        }
        
        self.months = months
    }
    
    func idForCurrentMonth() -> UUID {
        let today = Date()
        let firstDayOfCurrentMonth = today.firstDayOfMonth()

        let currentMonth = months.filter { $0.firstDayOfMonth == firstDayOfCurrentMonth }
        if (currentMonth.isEmpty) {
            return UUID()
        } else {
            return currentMonth[0].id
        }
    }
    
    func monthFromId(_ id: UUID?) -> Month {
        if id == nil {
            return Month(firstDayOfMonth: Date().firstDayOfMonth())
        }
        return months.first(where: {$0.id == id }) ?? Month(firstDayOfMonth: Date().firstDayOfMonth())
    }
    
    
    func addMonthAfter(_ count: Int) async {
        sleep(1)

        var firstDayOfLastMonth = months.last?.firstDayOfMonth ?? Date().firstDayOfMonth()
        for _ in 0..<count {
            firstDayOfLastMonth = firstDayOfLastMonth.plusMonth()
            let month = Month(firstDayOfMonth: firstDayOfLastMonth)
            DispatchQueue.main.async {
                self.months.append(month)
            }
        }

    }
    
    func addMonthBefore(_ count: Int) async {
        sleep(1)
        var firstDayOfFirstMonth = months.first?.firstDayOfMonth ?? Date().firstDayOfMonth()
        for _ in 0..<count {
            firstDayOfFirstMonth = firstDayOfFirstMonth.minusMonth()
            let month = Month(firstDayOfMonth: firstDayOfFirstMonth)
            DispatchQueue.main.async {
                self.months.insert(month, at: 0)
            }
        }

    }
}
