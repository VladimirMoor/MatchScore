//
//  MatchDetailView.swift
//  MatchDetailView
//
//  Created by Владимир Муравьев on 07.09.2021.
//

import SwiftUI

struct MatchDetailView: View {
    
    let match: Match
    let homeTeamGoals: Int
    let visitTeamGoals: Int
    
    var body: some View {
        HStack {
        Text(match.homeTeam?.name ?? "")
                .frame(maxWidth: .infinity)

        Text("\(homeTeamGoals) : \(visitTeamGoals)")
                .padding(.horizontal, 20)

        Text(match.visitTeam?.name ?? "")
                .frame(maxWidth: .infinity)

        }
        .font(.title2)
        
        Spacer()
        
        EventsList(match: match)
        
    }
}

