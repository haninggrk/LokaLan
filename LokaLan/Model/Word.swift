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
    var username:String{
        return word.username ?? ""
    }
    var downvote: Int32{
        return word.downvote
    }
    
    var upvote: Int32{
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
        get{
            return word.published_id != 0        }
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
    
    var published_id: Int32{
        set{
            word.published_id = (newValue) 
        }get{
            return word.published_id
        }
    }
    var user_id: Int32{
        set{
            word.user_id = (newValue)
        }get{
            return word.user_id
        }
    }
    func save(){
        WordViewModel.shared.update(word: self)
    }
    
    func pushToGlobal(){
        WordViewModel.shared.pushToGlobal(word: self, completionHandler: { p_id in
            self.word.published_id = p_id
            self.save()
            WordViewModel.shared.getAllWords()

        })
        
    }
    
    func unpublish(){
        WordViewModel.shared.UnpublishWord(id: Int(self.published_id)) { success in
            if(success){
            }
        }
        self.word.published_id = 0
        self.save()
    }
}


