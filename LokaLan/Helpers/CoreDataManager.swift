//
//  CoreDataManager.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 21/06/23.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    private init(){
        persistentContainer = NSPersistentContainer(name: "LokaLan")
        persistentContainer.loadPersistentStores{(description, error) in
            if let error = error{
                fatalError("Unable to start core data, \(error)")
            }
        }
    }
}
