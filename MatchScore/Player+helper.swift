//
//  Player+helper.swift
//  Player+helper
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import Foundation

extension Player {
    static let possibleRoles = ["Goalkeeper", "Defender", "Midfielder", "Forward"]
}

extension Player {
    
    func getGoals() -> Int {
        
        var totalGoals = 0
        
        if let allEvents = self.events?.allObjects as? [Event] {
            totalGoals = allEvents.filter { $0.type == "Goal" }.count
        }
        
        return totalGoals
        
    }
    
}
