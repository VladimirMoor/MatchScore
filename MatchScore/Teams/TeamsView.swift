//
//  TeamsView.swift
//  TeamsView
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import SwiftUI
import CoreData

struct TeamsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Team.entity(), sortDescriptors: []) var teams: FetchedResults<Team>
    @State private var isShowingNewTeamView = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink(destination: NewTeamView(), isActive: $isShowingNewTeamView) {
                    EmptyView()
                }
                
                List {
                    ForEach(teams) { team in
                        NavigationLink(destination: TeamDetailView(team: team)) {
                            HStack {
                                Text(team.name ?? "")
                                Text("(\(team.city ?? ""))")
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Teams")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingNewTeamView = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            
        }
    }

}


struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
