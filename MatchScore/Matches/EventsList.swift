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
                    TimeStamp(event: event)
                    if event.team == match.homeTeam {
                        EventPic(event: event)
                        Text(event.author?.fullName ?? "")
                     //   Text("[\(Int(event.author?.number ?? 0))]")
                    } else {
                        Spacer()
                        Text(event.author?.fullName ?? "")
                      //  Text("[\(Int(event.author?.number ?? 0))]")
                        EventPic(event: event)
                    }
                }
            }
            .onDelete(perform: deleteEvent)
        }
        .listStyle(.inset)
        
    }
    
    struct EventPic: View {
        let event: Event
        
        var body: some View {
            
            switch(event.type) {
            case "Goal": Text("⚽️")
            case "Yellow card": Text("🟨")
            case "Red card": Text("🟥")
            default: Text("?")
            }
            
        }
    }
    
    func deleteEvent(at offset: IndexSet) {
        offset.forEach { index in
            let event = events[index]
            if let moc = match.managedObjectContext {
                moc.delete(event)
                try? moc.save()
            }
        }
    }
}

