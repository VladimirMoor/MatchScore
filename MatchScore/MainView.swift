//
//  MainView.swift
//  MainView
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        TabView {
            MatchesListView()
                .tabItem {
                    Label("Matches", systemImage: "sportscourt")
                }
            
            TeamsView()
                .tabItem {
                    Label("Teams", systemImage: "person.3")
                }
            
            BestPlayers()
                .tabItem {
                    Label("Best players", systemImage: "list.star")
                }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
