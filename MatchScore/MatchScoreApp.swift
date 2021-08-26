//
//  MatchScoreApp.swift
//  MatchScore
//
//  Created by Владимир Муравьев on 25.08.2021.
//

import SwiftUI

@main
struct MatchScoreApp: App {
    
    let coreDataManager = CoreDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.context)
        }
    }
}
