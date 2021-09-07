//
//  NewMatchCreateView.swift
//  NewMatchCreateView
//
//  Created by Владимир Муравьев on 27.08.2021.
//

import SwiftUI
import CoreData

struct NewMatchCreateView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Team.entity(), sortDescriptors: []) var teams: FetchedResults<Team>
    @State private var homeTeam: Team = Team()
    @State private var visitTeam: Team = Team()
    @State private var match: Match = Match()

    
    let oneHalfDurations = [1, 5 , 10, 15, 20 ,30, 45, 60]
    @State private var oneHalfDuration = 45
    @State private var isShowMatchView = false
    
    var body: some View {

        NavigationView {
        VStack {
            
                Form {

                    Picker("Home Team", selection: $homeTeam) {
                        ForEach(teams) { team in
                            Text(team.name ?? "").tag(team)
                        }
                    }

                    Picker("Visit Team", selection: $visitTeam) {
                        ForEach(teams) { team in
                            Text(team.name ?? "").tag(team)
                        }
                    }

                    Picker("One Half Duration(in minutes)", selection: $oneHalfDuration) {
                        ForEach(oneHalfDurations, id: \.self) { duration in
                            Text("\(duration) min.")
                        }
                    }

                    Section {
                        Button {
                       
                            match = Match(context: moc)
                            match.oneHalfDuration = Int16(oneHalfDuration)
                            match.homeTeam = homeTeam
                            match.visitTeam = visitTeam
                            match.startDate = Date()

                            try? moc.save()

                            isShowMatchView = true

                        } label: {
                            Text("Start the Game!")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                        .disabled(homeTeam.managedObjectContext == nil || visitTeam.managedObjectContext == nil)
                        
                    }

                }
                
        }
        .navigationTitle("Create Match")
        .fullScreenCover(isPresented: $isShowMatchView, onDismiss: { presentationMode.wrappedValue.dismiss() } ) {
            CurrentMatchView(match: match)
        }
        }
        }

    }



