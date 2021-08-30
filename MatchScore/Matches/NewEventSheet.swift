//
//  NewEventSheet.swift
//  NewEventSheet
//
//  Created by Владимир Муравьев on 30.08.2021.
//

import SwiftUI

struct NewEventSheet: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var match: Match
    let isHomeTeameEvent: Bool
    let count: Int
    @State private var type = "Goal"
    
    var body: some View {
        
        NavigationView {
        Form {
            
            Picker("Choose event:", selection: $type) {
                ForEach(Event.possibleEvents, id:\.self) { eventType in
                    Text(eventType)
                }
            }
            .pickerStyle(.segmented)
            
            Text(type)
            
        }
        }
        
        
    }
}

