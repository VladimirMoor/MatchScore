//
//  PlayersList.swift
//  PlayersList
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import SwiftUI

struct PlayersList: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var team: Team
    var players: FetchRequest<Player>
    
    init(team: Team,filter: String) {
        if filter != "All" {
            players = FetchRequest<Player>(entity: Player().entity, sortDescriptors: [NSSortDescriptor(keyPath: \Player.number, ascending: true)], predicate: NSPredicate(format: "role = %@", filter))
        } else {
            players = FetchRequest<Player>(entity: Player().entity, sortDescriptors: [NSSortDescriptor(keyPath: \Player.number, ascending: true)])
        }
        self.team = team

    }
    
    var body: some View {
        VStack {
        List {
            ForEach(players.wrappedValue) { player in
                HStack {
                    Text("\(player.number)")
                    Text(player.fullName ?? "Noname")
                    Text(player.role ?? "None")
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let player = players.wrappedValue[index]
                    moc.delete(player)
                    try? moc.save()
                }
            }
        }
        

        }
    }
}


