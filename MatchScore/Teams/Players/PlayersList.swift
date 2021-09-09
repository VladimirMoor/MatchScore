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
    var teamPlayers: [Player]
    
    init(team: Team, filter: String) {

        if let allPlayers = team.players?.allObjects as? [Player] {
            if filter != "All" {
                teamPlayers = allPlayers.filter { $0.role == filter }
            } else {
                teamPlayers = allPlayers
            }
            
        } else {
            teamPlayers = []
        }
        
        self.team = team

    }
    
    var body: some View {
        VStack {
        List {
            ForEach(teamPlayers) { player in
                HStack {
                    Text("\(player.number)")
                    Text(player.fullName ?? "Noname")
                    Text(player.role ?? "None")
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(3)
                        
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let player = teamPlayers[index]
                    moc.delete(player)
                    try? moc.save()
                }
            }
        }
        

        }
    }
}


