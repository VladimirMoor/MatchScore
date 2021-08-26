//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Владимир Муравьев on 26.08.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        
        container = NSPersistentContainer(name: "MatchScoreCoreData")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error in loading PersistentStores: \(error.localizedDescription)")
            }
        }
        
        context = container.viewContext
        
    }
    
    
}
