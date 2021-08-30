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

    var body: some View {

        VStack {
            
        HStack {
            Text(match.homeTeam?.name ?? "" )
        Text(matchCurrentTime)
                .font(.headline)
                .padding()
            Text(match.visitTeam?.name ?? "")
        }

            HStack(spacing: 50) {
                
            Button {
                
                let newEvent = Event(context: moc)
                newEvent.team = match.homeTeam
                newEvent.type = "Goal"
                newEvent.time = Int16(count)
                match.addToEvents(newEvent)
                
                try? moc.save()
                print("HT event saved!")
                
            } label: {
                Text("HT event")
                    .bold()
                    .padding()
                    .background(Color.green)
                    .clipShape(Capsule())
            }

            Button {
                print("VT event")

            } label: {
                Text("VT event")
                    .bold()
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.primary)
                    .clipShape(Capsule())
            }
    
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

