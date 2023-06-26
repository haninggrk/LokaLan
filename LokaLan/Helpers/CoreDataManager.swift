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
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    

    func getAllWords() -> [Word]{
        let request:NSFetchRequest<Word> = Word.fetchRequest()
        do{
            return try viewContext.fetch(request)
        } catch{
            return []
        }
    }
    
    func deleteWord(word:Word){
        viewContext.delete(word)
        save()
    }
    
    func getWordById(id: NSManagedObjectID)->Word?{
        do{
            return try viewContext.existingObject(with: id) as? Word
        }catch{
            return nil
        }
    }
    
    
    func save(){
        do{
            try viewContext.save()
        }catch{
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
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
