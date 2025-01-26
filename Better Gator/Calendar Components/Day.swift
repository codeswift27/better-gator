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
//    var moods: [Emotion]
    
    init(date: Date?) {
        self.date = date
//        self.moods = moods.map { Emotion(rawValue: Int($0.emotion)) ?? .calm }
    }
    
}
