//
//  BestPlayersView.swift
//  BestPlayersView
//
//  Created by Владимир Муравьев on 08.09.2021.
//

import SwiftUI

struct RefreshView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Match.entity(), sortDescriptors: []) var matches: FetchedResults<Match>
    @FetchRequest(entity: Event.entity(), sortDescriptors: []) var events: FetchedResults<Event>
    
    var body: some View {
        
        Button(action: {
            
            events.forEach { event in
                moc.delete(event)
            }
            
            for match in matches {
                moc.delete(match)
            }
            
            try? moc.save()
            
        }, label: {
            Text("Delete matches and events")
        })
    }
}

