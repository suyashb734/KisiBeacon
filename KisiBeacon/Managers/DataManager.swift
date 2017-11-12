//
//  DataManager.swift
//  KisiBeacon
//
//  Created by Suyash Taneja on 09/11/17.
//  Copyright © 2017 Suyash Taneja. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class DataManager {
    static let shared = DataManager()
    
    var managedContext: NSManagedObjectContext?
    var errorOccured: ((Error) -> ())?
    
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            }else {
                self.managedContext = container.viewContext
            }
        })
        return container
    }()
    
    // Computed property to get all beacons stored in database.
    var beaconsInDatabase: [Beacon] {
        let fetchRequest: NSFetchRequest<Beacon> = Beacon.fetchRequest()
        do {
            let beacons = try managedContext?.fetch(fetchRequest)
            return beacons ?? []
        } catch {
            return []
        }
    }
    
    init() {
        managedContext = persistentContainer.viewContext
    }
    
    func updateBeaconUnlockCount(clBeacon: CLBeacon) {
        if let beacon = beaconsInDatabase.first(where: {($0.uuid == clBeacon.proximityUUID) && ($0.major == clBeacon.major.int16Value) && $0.minor == clBeacon.minor.int16Value}) {
            beacon.lastUnlockTime = Date()
            beacon.unlockCount += 1
        }else {
            if let moc = managedContext {
                let beacon = Beacon(context: moc)
                beacon.uuid = clBeacon.proximityUUID
                beacon.major = clBeacon.major.int16Value
                beacon.minor = clBeacon.minor.int16Value
                beacon.lastUnlockTime = Date()
                beacon.unlockCount = 1
            }
        }
        saveContext { (error) in
            self.errorOccured?(error)
        }
    }
    
    // MARK: - Core Data Saving support
    func saveContext (failure: @escaping (Error) -> ()) {
        if let context = managedContext, context.hasChanges {
            do {
                try context.save()
            } catch {
                failure(error)
            }
        }
    }
}
