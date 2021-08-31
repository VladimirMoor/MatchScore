//
//  NewEventSheet.swift
//  NewEventSheet
//
//  Created by Владимир Муравьев on 30.08.2021.
//

import SwiftUI

struct NewEventSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var match: Match
    let isHomeTeamEvent: Bool
    let count: Int
    @State private var type = "Goal"
    @State private var author: Player = Player()
    var thisTeamPlayers: [Player] = []
    
    init(match: Match, isHomeTeamEvent: Bool, count: Int) {
        self.match = match
        self.isHomeTeamEvent = isHomeTeamEvent
        self.count = count
        
        if isHomeTeamEvent {
            if let players = match.homeTeam?.players?.allObjects as? [Player] {
                thisTeamPlayers = players
            }
        } else {
            if let players = match.visitTeam?.players?.allObjects as? [Player] {
                thisTeamPlayers = players
            }
    }
    }
    
    
    var body: some View {
        
        NavigationView {
        Form {
            
            Section {
            Text("Choose event")
            Picker("Event", selection: $type) {
                ForEach(Event.possibleEvents, id: \.self) { eventName in
                    Text(eventName)
                }
            }
            .pickerStyle(.segmented)
            }
            
            Section {
                Picker("Choose event's author", selection: $author) {
                    ForEach(thisTeamPlayers) { player in
                        
                        Text(player.fullName ?? "").tag(player)
                    }
                }
            }
            
            Button {
                
                if let existingMoc = match.managedObjectContext {
                    let newEvent = Event(context: existingMoc)
                    newEvent.match = match
                    newEvent.team = isHomeTeamEvent ? match.homeTeam : match.visitTeam
                    newEvent.author = author
                    newEvent.type = type
                    newEvent.time = Int16(count)
                    
                    try? existingMoc.save()
                    
                    presentationMode.wrappedValue.dismiss()
                }
                
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
            .disabled(author.managedObjectContext == nil)
            

            
            
            
        }
        }
        
        
    }
}

