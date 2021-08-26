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

            ZStack(alignment: .bottomTrailing) {
                
            PlayersList(team: team , filter: roleFilter)
            
                Button(action: {
                    isShowingFilterList = true
                }, label: {
                    VStack(spacing: 5) {
                        if roleFilter != "All" {
                        Text(roleFilter)
                            .font(.footnote)
                            
                        }
                        
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                    }
                })
                    .padding(44)
            }
            .sheet(isPresented: $isShownAddPlayerView) {
                NewPlayerView(team: team)
            }
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShownAddPlayerView = true
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
                .sheet(isPresented: $isShowingFilterList, content: {
                    RoleFilterView(role: $roleFilter)
                })
        
        .navigationTitle(team.name ?? "")
        .environment(\.managedObjectContext, moc)
    }
    }
    
    
}

