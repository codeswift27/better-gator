//
//  Day.swift
//  Better Gator
//
//  Created by Lexline Johnson on 1/26/25.
//

import Foundation

struct Day: Identifiable {
    var id: UUID = UUID()
    
    var date: Date?
    var hasEvent: Bool
    
    init(date: Date?) {
        self.date = date
        self.hasEvent = date?.day().isMultiple(of: 5) ?? false
    }
    
}
