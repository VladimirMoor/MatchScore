//
//  MatchesView.swift
//  MatchesView
//
//  Created by Владимир Муравьев on 27.08.2021.
//

import SwiftUI

struct MatchesListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Match.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Match.startDate, ascending: true)]) var matches: FetchedResults<Match>
    @FetchRequest(entity: Event.entity(), sortDescriptors: []) var events: FetchedResults<Event>
    @State private var isShowNewMatchView = false
    
    var body: some View {
        NavigationView {
        VStack {
        
            NavigationLink(destination: NewMatchCreateView(), isActive: $isShowNewMatchView) {
                EmptyView()
            }
        
            Text("Events total: \(events.count)")
            
        List {
            ForEach(matches) { match in
                MatchView(match: match)
            }
            .onDelete(perform: removeMatch)
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
    
    func removeMatch(at offsets: IndexSet) {
        offsets.forEach { index in
            let match = matches[index]
            moc.delete(match)
            try? moc.save()
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesListView()
    }
}
