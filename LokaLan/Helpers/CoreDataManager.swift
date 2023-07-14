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
    
    func getWordByPublishedID(publishedID: Int32) -> Word? {
        let request: NSFetchRequest<Word> = Word.fetchRequest()
        request.predicate = NSPredicate(format: "published_id == %d", publishedID)
        
        do {
            let results = try viewContext.fetch(request)
            return results.first
        } catch {
            print("Error fetching word: \(error.localizedDescription)")
            return nil
        }
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
