//
//  CalendarUIView.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/25/25.
//

import SwiftUI
import UIKit


struct CalendarViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CalendarUIViewController {
        CalendarUIViewController()
    }
    
    func updateUIViewController(_ uiViewController: CalendarUIViewController, context: Context) {}
}

class CalendarUIViewController: UIViewController {
    var calendarViewDelegate: CalendarViewDelegate = CalendarViewDelegate()
    init() {
        super.init(nibName: nil, bundle: nil)
        let calendarView = UICalendarView()
        calendarView.delegate = calendarViewDelegate
        view = calendarView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CalendarViewDelegate: NSObject, UICalendarViewDelegate {
    var calendarView: UICalendarView? = nil
    var decorations: [Date?: [UICalendarView.Decoration]]
    
    override init() {
        let valentinesDay = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            year: 2025,
            month: 1,
            day: 24
        )
        
        // Create a calendar decoration for Valentine's day.
        let heart = UICalendarView.Decoration.image(
            UIImage(systemName: "heart.fill"),
            color: UIColor.red,
            size: .large
        )
        let star = UICalendarView.Decoration.image(
            UIImage(systemName: "star.fill"),
            color: UIColor.red,
            size: .large
        )
        
        decorations = [valentinesDay.date: [heart, star]]
    }
    
    // Return a decoration (if any) for the specified day.
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        // Get a copy of the date components that only contain
        // the calendar, year, month, and day.
        let day = DateComponents(
            calendar: dateComponents.calendar,
            year: dateComponents.year,
            month: dateComponents.month,
            day: dateComponents.day
        )
        
        // Return any decoration saved for that date.
        var first: UICalendarView.Decoration? = nil
        if let decorationList = decorations[day.date] {
            if !decorationList.isEmpty {
                first = decorations[day.date]![0]
                decorations[day.date]?.remove(at: 0)
            }
        }
        return first
    }
}



