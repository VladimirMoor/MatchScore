//
//  TeamViewDetail.swift
//  TeamViewDetail
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import SwiftUI

struct TeamDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var team: Team
    @State private var isShownAddPlayerView = false
    @State private var isShowingFilterList = false
    @State private var roleFilter = "All"
    
    var body: some View {
        VStack {
            Text("Role filter choosen: \(roleFilter)")
            PlayersList(team: team , filter: roleFilter)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShownAddPlayerView = true
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingFilterList = true
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        }
                        
                    }
                }
                .sheet(isPresented: $isShowingFilterList, content: {
                    RoleFilterView(role: $roleFilter)
                })
        .sheet(isPresented: $isShownAddPlayerView) {
            NewPlayerView(team: team)
        }
        .navigationTitle(team.name ?? "")
        .environment(\.managedObjectContext, moc)
    }
    }
    
    
}

