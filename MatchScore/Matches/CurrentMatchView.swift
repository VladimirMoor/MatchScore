//
//  CurrentMatchView.swift
//  CurrentMatchView
//
//  Created by Владимир Муравьев on 29.08.2021.
//

import SwiftUI
import CoreData

struct CurrentMatchView: View {
    
    @ObservedObject var homeTeam: Team
    @ObservedObject var visitTeam: Team

    @State private var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var count = 0
    @State private var matchCurrentTime = "00:00"

    var body: some View {
        VStack {
        HStack {
        Text(homeTeam.name ?? "")
        Text(matchCurrentTime)
                .font(.headline)
                .padding()
        Text(visitTeam.name ?? "")
        }
            
            
            
            
     }
        .navigationBarHidden(true)
        .onReceive(time) { _ in
            matchCurrentTime = secondsToString(count)
            count += 1
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

