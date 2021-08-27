//
//  MatchesView.swift
//  MatchesView
//
//  Created by Владимир Муравьев on 27.08.2021.
//

import SwiftUI

struct MatchesListView: View {
    
    @FetchRequest(entity: Match.entity(), sortDescriptors: []) var matches: FetchedResults<Match>
    @State private var isShowNewMatchView = false
    
    var body: some View {
        NavigationView {
        VStack {
        
            NavigationLink(destination: NewMatchCreateView(), isActive: $isShowNewMatchView) {
                EmptyView()
            }
            
        List {
            ForEach(matches) { match in
                MatchView(match: match)
            }
        }
        
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowNewMatchView = true
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .navigationTitle("Matches")
        }
        
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesListView()
    }
}
