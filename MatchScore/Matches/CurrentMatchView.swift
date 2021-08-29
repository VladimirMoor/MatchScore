//
//  CurrentMatchView.swift
//  CurrentMatchView
//
//  Created by Владимир Муравьев on 29.08.2021.
//

import SwiftUI
import CoreData

struct CurrentMatchView: View {
    
    let homeTeamID: NSManagedObjectID
    let visitTeamID: NSManagedObjectID
    let oneHalfDuration: Int
    let startMatchDate = Date()
    @State private var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var count = 0
    @State private var matchCurrentTime = ""
    
    var body: some View {
        VStack {
            Text(matchCurrentTime)
        }
        .onReceive(time) { _ in
            
            count += 1
            matchCurrentTime = secondsToString(count)
        }
        
    }
    
    func secondsToString(_ seconds: Int) -> String {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds)) ?? "--"
    }
}

