//
//  TeamViewDetail.swift
//  TeamViewDetail
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import SwiftUI

struct TeamDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var team: Team
    @State private var isShownAddPlayerView = false
    @State private var isShowingFilterList = false
    @State private var roleFilter = "All"
    @State private var isShowRemoveAlert = false
    
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
                    
                    ToolbarItem(placement: .principal) {
                        Button {
                            isShowRemoveAlert = true
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                }
                .sheet(isPresented: $isShowingFilterList, content: {
                    RoleFilterView(role: $roleFilter)
                })
            
                .alert(isPresented: $isShowRemoveAlert) {
                    Alert(
                    
                        title: Text("Delete team"),
                        message: Text("Are you sure you want to delete it? It deletes all matches and all players of this team."),
                        primaryButton: Alert.Button.destructive(Text("Yes, delete it"), action: {
                            moc.delete(team)
                            try? moc.save()
                            presentationMode.wrappedValue.dismiss()
                            
                        }),
                        secondaryButton: Alert.Button.cancel(Text("No, keep it"), action: {
                            
                        })
                    
                    )
                }
        .navigationTitle(team.name ?? "")
        .environment(\.managedObjectContext, moc)
    }
    }
    
    
}

