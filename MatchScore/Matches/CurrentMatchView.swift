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
                print("HT event")
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

     }
        .navigationBarHidden(true)
        .onReceive(time) { _ in
            matchCurrentTime = secondsToString(count)
            count += 1
        }
    }
    
    func secondsToString(_ seconds: Int) -> String {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds)) ?? "--"
    }
}

