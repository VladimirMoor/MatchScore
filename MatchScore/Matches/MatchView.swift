//
//  MatchView.swift
//  MatchView
//
//  Created by Владимир Муравьев on 27.08.2021.
//

import SwiftUI

struct MatchView: View {
    
    @ObservedObject var match: Match
    var events: [Event]
    let homeTeamGoals: Int
    let visitTeamGoals: Int
    
    
    init(match: Match) {
        if let allEvents = match.events?.allObjects as? [Event] {
            events = allEvents
        } else {
            events = []
        }
        
        homeTeamGoals = events.filter { $0.type == "homeTeamGoal" }.count
        visitTeamGoals = events.filter { $0.type == "visitTeamGoal" }.count
        
        self.match = match
        
        
    }
    
    var body: some View {
        
                HStack {
                    
                Text(match.homeTeam?.name ?? "")
                Text(match.visitTeam?.name ?? "")
                Text("\(homeTeamGoals) : \(visitTeamGoals)")
                    
        }
    }
}


