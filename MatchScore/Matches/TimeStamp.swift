//
//  TimeStamp.swift
//  TimeStamp
//
//  Created by Владимир Муравьев on 02.09.2021.
//

import SwiftUI

struct TimeStamp: View {
    @ObservedObject var event: Event
    
    var body: some View {
        
        if event.gameTimer?.secondHalfTimer == 0 {
            if event.gameTimer?.firstHalfExtraTimer == 0 {
                Text(Event.secondsToString(Int(event.gameTimer?.firstHalfTimer ?? 0)))
                    .font(.caption)
                
            } else {
                HStack {
                Text(Event.secondsToString(Int((event.gameTimer?.firstHalfTimer ?? 0))))
                Text("+")
                Text(Event.secondsToString(Int((event.gameTimer?.firstHalfExtraTimer ?? 0))))
                }
                .font(.caption)
            }
            
        } else {
            if event.gameTimer?.secondHalfExtraTimer == 0 {
                Text(Event.secondsToString(Int(event.gameTimer?.secondHalfTimer ?? 0)))
                    .font(.caption)
            } else {
                HStack {
                Text(Event.secondsToString(Int((event.gameTimer?.secondHalfTimer ?? 0))))
                Text("+")
                Text(Event.secondsToString(Int((event.gameTimer?.secondHalfExtraTimer ?? 0))))
                }
                .font(.caption)
            }
        }
    }
}


