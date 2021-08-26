//
//  ContentView.swift
//  MatchScore
//
//  Created by Владимир Муравьев on 25.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("hi")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 
 CurrentMatchView template
 
 struct ContentView: View {
     
     @State private var gameStartDate = Date()
     @State private var eventMoment = Date()
     @State private var diffInSeconds: Int?
     @State private var diffAsString = ""
     
     
     var body: some View {
         VStack {
             
             Text("\(gameStartDate)")
             
             Button {
                 gameStartDate = Date()
             } label: {
                 Text("Start")
             }
             
             Button {
                 eventMoment = Date()
                 
                 let diffComponents = Calendar.current.dateComponents([.second], from: gameStartDate, to: eventMoment)
                 
                 if let diffInSeconds = diffComponents.second {
                     let formatter = DateComponentsFormatter()
                     formatter.allowedUnits = [.hour, .minute, .second]
                     formatter.unitsStyle = .positional
                     
                     diffAsString = formatter.string(from: TimeInterval(diffInSeconds)) ?? "error"
                     print(diffInSeconds)
                 }

             } label: {
                 Text("New Event in game")
             }
             
                 Text(diffAsString)
                 .font(.largeTitle)
                 .padding()
             

         }
 }
 }

 
 
 
 
 */
