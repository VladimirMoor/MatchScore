//
//  NewMatchCreateView.swift
//  NewMatchCreateView
//
//  Created by Владимир Муравьев on 27.08.2021.
//

import SwiftUI
import CoreData

struct NewMatchCreateView: View {
    
    @FetchRequest(entity: Team.entity(), sortDescriptors: []) var teams: FetchedResults<Team>
    @State private var homeTeamID = NSManagedObjectID()
    @State private var visitTeamID = NSManagedObjectID()

    let oneHalfDurations = [5 ,10 ,20 ,30, 45, 60]
    @State private var oneHalfDuration = 45
    @State private var isShowMatchView = false

    
    
    var body: some View {
        
        NavigationLink(destination: CurrentMatchView(homeTeamID: homeTeamID, visitTeamID: visitTeamID, oneHalfDuration: oneHalfDuration), isActive: $isShowMatchView) {
            EmptyView()
        }
        
        Form {
            Picker("Home Team", selection: $homeTeamID) {
                ForEach(teams) { team in
                    Text(team.name ?? "").tag(team.objectID)
                }
            }
            
            Picker("Visit Team", selection: $visitTeamID) {
                ForEach(teams) { team in
                    Text(team.name ?? "").tag(team.objectID)
                }
            }
            
            Picker("One Half Duration(in minutes)", selection: $oneHalfDuration) {
                ForEach(oneHalfDurations, id: \.self) { duration in
                    Text("\(duration) min.")
                }
            }
            
            
            Section {
            Button {
                
                isShowMatchView = true
                print("Hi")
                
                
            } label: {
                Text("Start the Game!")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            }

        }
        .navigationTitle("Create new match")
        .navigationBarTitleDisplayMode(.automatic)
        
    }
}


