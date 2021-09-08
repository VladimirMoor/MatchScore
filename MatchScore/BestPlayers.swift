//
//  BestPlayers.swift
//  BestPlayers
//
//  Created by Владимир Муравьев on 08.09.2021.
//

import SwiftUI
import CoreData

struct BestPlayers: View {
    
    @FetchRequest(entity: Player.entity(), sortDescriptors: []) var players: FetchedResults<Player>
    
    var bestByGoals: [Player] {
        players.sorted { firstPlayer, secondPlayer in
            
            var firstPlayerGoals = 0
            var secondPlayerGoals = 0
            
            if let events1 = firstPlayer.events?.allObjects as? [Event] {
                firstPlayerGoals = events1.filter { $0.type == "Goal" }.count
            }
            
            if let events2 = secondPlayer.events?.allObjects as? [Event] {
                secondPlayerGoals = events2.filter { $0.type == "Goal" }.count
            }
            
            return firstPlayerGoals > secondPlayerGoals
        }
        
    }
    
    var body: some View {
        
        VStack {
            
            
            
        List {
            HStack {
                Text("Player")
                    .font(.title3)
                    .bold()
                Spacer()
                Text("Goals")
                    .font(.title3)
                    .bold()
            }
            
            
            ForEach(bestByGoals) { player in
                HStack {
                Text(player.fullName ?? "")
                Spacer()
                Text("\(player.getGoals())")
                }
            }
        }
        }
    }
}

