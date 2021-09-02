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
    
    @State private var firstHalfTimer = 0
    @State private var firstHalfAddTimer = 0
    @State private var secondHalfTimer = 0
    @State private var secondHalfAddTimer = 0
    
    @State private var isShowNewEventSheet = false
    
    @State private var isFirstHalfStart = false
    @State private var isFirstHalfEnd = false
    @State private var isSecondHalfStart = false
    @State private var isSecondHalfEnd = false
    @State private var isMatchEnd = false
    
    @State private var counter = 0
    @State private var newEvent: Event = Event()
    
    @State private var choosedTeam: Team = Team()
    @State private var newGameTime = GameTimer()
    
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
                .frame(maxWidth: .infinity)
                .font(.largeTitle)
            }
            .background(Color.yellow)
            

            Text("\(firstHalfTimer)-\(firstHalfAddTimer)-\(secondHalfTimer)-\(secondHalfAddTimer)")
                .frame(maxWidth: 100)
                .font(.headline)
                .padding()
                .background(Color.green)
            
            VStack {
            Text(match.visitTeam?.name ?? "")
            Text("\(visitTeamGoals)")
                .frame(maxWidth: .infinity)
                .font(.largeTitle)
            }
            .background(Color.blue)
        }
            
            HStack {
                Button("Stop first half") {
                    isFirstHalfEnd = true
                }
                
                Button("Start second half") {
                    isSecondHalfStart = true
                }
            }

            HStack(spacing: 50) {
                
            Button {

                newGameTime = GameTimer(context: moc)
                newGameTime.firstHalfTimer = Int16(firstHalfTimer)
                newGameTime.firstHalfExtraTimer = Int16(firstHalfAddTimer)
                newGameTime.secondHalfTimer = Int16(secondHalfTimer)
                newGameTime.secondHalfExtraTimer = Int16(secondHalfAddTimer)
               
                
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
                
                newGameTime = GameTimer(context: moc)
                newGameTime.firstHalfTimer = Int16(firstHalfTimer)
                newGameTime.firstHalfExtraTimer = Int16(firstHalfAddTimer)
                newGameTime.secondHalfTimer = Int16(secondHalfTimer)
                newGameTime.secondHalfExtraTimer = Int16(secondHalfAddTimer)
                

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
             NewEventSheet(match: match, moment: newGameTime, isHomeTeamEvent: isHomeTeamEvent )
            }
            
        EventsList(match: match)
            
            
     }
        .navigationBarHidden(true)
        .onReceive(time) { _ in

            
            if isFirstHalfEnd == false {
                
                if firstHalfTimer < match.oneHalfDuration * 60 {
                    firstHalfTimer += 1
                } else {
                    firstHalfAddTimer += 1
                }
            
            } else {
                
                if isSecondHalfStart == true {
                    counter += 1
                    if secondHalfTimer < match.oneHalfDuration * 2 * 60 {
                    secondHalfTimer = Int(match.oneHalfDuration * 60) + counter
                    } else {
                        secondHalfAddTimer += 1
                    }
                }
            }
            

        }
        
    }

}

