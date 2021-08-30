//
//  Event+helper.swift
//  Event+helper
//
//  Created by Владимир Муравьев on 30.08.2021.
//

import Foundation

extension Event {
    static let bossibleEvents = ["Goal", "Red card", "Yellow card"]
    
    static func secondsToString(_ seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds)) ?? "--"
    }
}
