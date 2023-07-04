//
//  Word.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 26/06/23.
//

import Foundation
import CoreData

struct WordModel: Hashable{
    let word:Word
    var id: NSManagedObjectID{
        return word.objectID
    }
    var name: String{
        return word.word ?? ""
    }
    
    var desc: String{
        return word.desc ?? ""
    }
    
    var audio_path:String{
        return word.audio_path ?? ""
    }
    
    var downvote: Int16{
        return word.downvote
    }
    
    var upvote: Int16{
        return word.upvote
    }
    
    var is_local: Bool{
        set{
            word.is_local = newValue
        }
        get{
            return word.is_local
        }
    }
    
    var is_published: Bool{
        set{
            word.is_published = newValue
        }
        get{
            return word.is_published
        }
    }
    var meaning: String{
        return word.meaning ?? ""
    }
    var usage_examples: String{
        return word.usage_examples ?? ""
    }
    var is_widget: Bool{
        set{
            word.is_widget = newValue
        }
        get{
            return word.is_widget
        }
        
    }
    
    func save(){
        WordViewModel.shared.update(word: self)
    }
}


