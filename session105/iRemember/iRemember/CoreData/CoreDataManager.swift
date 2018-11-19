//
//  CoreDataManager.swift
//  iRemember
//
//  Created by Răzvan-Gabriel Geangu on 19/11/2018.
//  Copyright © 2018 Răzvan-Gabriel Geangu. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    public static let shared = CoreDataManager()
    
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "iRemember")
        container.loadPersistentStores { (description, error) in
            guard error == nil else {
                print("Error: \(error.debugDescription)")
                return
            }
        }
        
        return container
    }
    
    var managedContext: NSManagedObjectContext {
        return container.viewContext
    }
}
