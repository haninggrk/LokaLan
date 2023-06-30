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
        return word.is_local
    }
    
    var is_published: Bool{
        return word.is_published
    }
    var meaning: String{
        return word.meaning ?? ""
    }
    var usage_examples: String{
        return word.usage_examples ?? ""
    }
    
}

struct WordData: Codable, Hashable {
    var id: Int
    var word: String
    var meaning: String
    var description: String
    var audio_path: String?
    var upvote: Int
    var downvote: Int
    var user_id: Int
    var created_at: String
    var updated_at: String
    var usage_examples: String
}
