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
            events = allEvents.sorted(by: {
                $0.time < $1.time
            })
        } else {
            events = []
        }

    }
    
    var body: some View {
        List {
            ForEach(events) { event in
                HStack {
                    Text("\(event.time)")
                    Text(event.type ?? "")
                    Text(event.author?.fullName ?? "No name")
                }
            }
        }
    }
}

