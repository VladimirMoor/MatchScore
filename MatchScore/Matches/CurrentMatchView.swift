//
//  CurrentMatchView.swift
//  CurrentMatchView
//
//  Created by Владимир Муравьев on 29.08.2021.
//

import SwiftUI
import CoreData

struct CurrentMatchView: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var match: Match
    @State private var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var count = 0
    @State private var matchCurrentTime = "00:00"
    @State private var isShowNewEventSheet = false
    @State private var isHomeTeamEvent = true
    
    var homeTeamGoals: Int {
        if let events = match.events?.allObjects as? [Event] {
            return events.filter { ($0.type == "Goal") && ($0.team == match.homeTeam) }.count
        } else { return 0 }
    }
    
    var visitTeamGoals: Int {
        if let events = match.events?.allObjects as? [Event] {
            return events.filter { ($0.type == "Goal") && ($0.team == match.visitTeam) }.count
        } else { return 0 }
    }

    
    var body: some View {

        VStack {
            
        HStack {
            VStack {
            Text(match.homeTeam?.name ?? "" )
            Text("\(homeTeamGoals)")
                .font(.largeTitle)
            }
            
            Text(matchCurrentTime)
                .font(.headline)
                .padding()
            
            VStack {
            Text(match.visitTeam?.name ?? "")
            Text("\(visitTeamGoals)")
                .font(.largeTitle)
            }
        }

            HStack(spacing: 50) {
                
            Button {
                isHomeTeamEvent = true
                isShowNewEventSheet = true
                
            } label: {
                Text("HT event")
                    .bold()
                    .padding()
                    .background(Color.green)
                    .clipShape(Capsule())
            }

            Button {
                isHomeTeamEvent = false
                isShowNewEventSheet = true

            } label: {
                Text("VT event")
                    .bold()
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.primary)
                    .clipShape(Capsule())
            }
    
         }
         .sheet(isPresented: $isShowNewEventSheet) {
                NewEventSheet(match: match, isHomeTeamEvent: isHomeTeamEvent, count: count)
            }
            
            EventsList(match: match)
     }
        
        .navigationBarHidden(true)
        .onReceive(time) { _ in
            matchCurrentTime = Event.secondsToString(count)
            count += 1
        }
        
    }

}

