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
        
        homeTeamGoals = events.filter { ($0.type == "Goal") && ($0.team == match.homeTeam) }.count
        visitTeamGoals = events.filter { ($0.type == "Goal") && ($0.team == match.visitTeam) }.count
        
        self.match = match
    }
    
    var body: some View {
        
                HStack {
                    
                Text(match.homeTeam?.name ?? "")
                Text(" - ")
                Text(match.visitTeam?.name ?? "")
                Text("\(homeTeamGoals) : \(visitTeamGoals)")
                    
        }
    }
}


