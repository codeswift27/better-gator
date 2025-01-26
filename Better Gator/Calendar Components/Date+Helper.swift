//
//  Date+Helper.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/26/25.
//

import Foundation

extension Date {
    func day() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return Int(dateFormatter.string(from: self))!
    }
    
    func month() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return Int(dateFormatter.string(from: self))!
    }
    
    func year() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return Int(dateFormatter.string(from: self))!
    }
    
    func monthString() -> String {
        let calendar = Calendar.current
        return calendar.shortStandaloneMonthSymbols[self.month() - 1]
    }
    
    func yearMonthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMMM"
        return dateFormatter.string(from: self)
    }
    
    func isWeekDay() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday! - 1
    }
    
    func daysInMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.count
    }
    
    static func addPadding(_ int: Int, _ targetDigit: Int ) -> String {
        return String(format: "%0\(targetDigit)d", int)
    }
    
    func firstDayOfMonth() -> Date {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.date(from: "\(Date.addPadding(self.year(), 4))/\(Date.addPadding(self.month(), 2))/\(Date.addPadding(self.day(), 2))")!
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func plusDate(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: count, to: self)!
    }
    
    func minusDate(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -count, to: self)!
    }
    
    func plusMonth(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: count, to: self)!
    }
    
    
    func minusMonth(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: -count, to: self)!
    }

    
    // is the date today (Bool)
    func isToday() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let todayDateString = dateFormatter.string(from: Date())
        let dateToCompareString = dateFormatter.string(from: self)
        return (todayDateString == dateToCompareString)
    }
    
    
    // is the date a weekend (Bool)
    func isWeekend() -> Bool {
        let weekday = self.isWeekDay()
        return ((weekday == 0 ) || (weekday == 6))
    }
        
        
        // is the date in the same month as today (Bool)
    func isCurrentMonth() -> Bool {
        let today = Date()
        return (today.year() == self.year()) && (today.month() == self.month())
    }
}
