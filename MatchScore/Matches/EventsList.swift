//
//  EventsList.swift
//  EventsList
//
//  Created by Владимир Муравьев on 30.08.2021.
//

import SwiftUI

struct EventsList: View {
    @ObservedObject var match: Match
    var events: [Event]
    
    init(match: Match) {
        self.match = match
        
        if let allEvents = match.events?.allObjects as? [Event] {
            events = allEvents.sorted {
                $0.date! < $1.date!
            }
        } else {
            events = []
        }

    }
    
    
    var body: some View {
        List {
            ForEach(events) { event in
                
                HStack {

                    if event.gameTimer?.secondHalfTimer == 0 {
                        if event.gameTimer?.firstHalfExtraTimer == 0 {
                            Text(Event.secondsToString(Int(event.gameTimer?.firstHalfTimer ?? 0)))
                            
                        } else {
                            HStack {
                            Text(Event.secondsToString(Int((event.gameTimer?.firstHalfTimer ?? 0))))
                            Text("+")
                            Text(Event.secondsToString(Int((event.gameTimer?.firstHalfExtraTimer ?? 0))))
                            }
                        }
                        
                    } else {
                        let timeString = Event.secondsToString(Int((event.gameTimer?.secondHalfTimer ?? 0) + (event.gameTimer?.secondHalfExtraTimer ?? 0)))
                        Text(timeString)
                    }
                    
                    Text(event.type ?? "")
                        .bold()
                    Text(event.author?.fullName ?? "No name")
                    Text("[ \(Int(event.author?.number ?? 0)) ]")
                    
                }
            }
        }
    }
}

