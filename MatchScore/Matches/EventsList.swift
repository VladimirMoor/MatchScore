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
                    Spacer()
                    Text(event.type ?? "")
                        .bold()
                    Text(event.author?.fullName ?? "")
                    Text("[\(Int(event.author?.number ?? 0))]")
                    
                }
            }
            .onDelete(perform: deleteEvent)
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

