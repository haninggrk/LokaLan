//
//  WordViewModel.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 22/06/23.
//

import Foundation
import AVFoundation
import CoreData
import AVFoundation

class WordViewModel: ObservableObject{
    
    @Published var audioRecorder: AVAudioRecorder?
    @Published var words: [WordModel] = []
    
    
    
    
    
    static var shared:WordViewModel = WordViewModel()
    
    var name: String = ""
    var meaning: String = ""
    var desc: String = ""
    var audio_path: String = ""
    var downvote: Int16 = 0
    var upvote: Int16 = 0
    var audioURL: URL?
    var fileName: String = ""
    func getAllWords(){
        words = CoreDataManager.shared.getAllWords().map(WordModel.init)
    }
    
    
    init(){
        getAllWords()
    }
    func save(){
        let word = Word(context: CoreDataManager.shared.viewContext)
        word.word = name
        word.meaning = meaning
        word.desc = desc
        word.audio_path = audio_path
        word.downvote = downvote
        word.upvote = upvote
        CoreDataManager.shared.save()
    }
    
    
    func delete(word:WordModel){
        let existingWord = CoreDataManager.shared.getWordById(id: word.id)
        if let existingWord = existingWord{
            CoreDataManager.shared.deleteWord(word: existingWord)
        }
    }
    
    
    func startRecording() {
        // Set up the audio session
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session: \(error.localizedDescription)")
        }
        
        
        
        let audioSettings: [String: Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        fileName = UUID().uuidString + ".wav" // Generate a unique file name using UUID
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        audioURL = documentsPath.appendingPathComponent(fileName)
        do {
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: audioSettings)
            audioRecorder!.record()
        } catch {
            print("Failed to create audio recorder: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        guard let audioURL = audioURL else { return }
        do{
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsDirectory.appendingPathComponent(fileName)
            
            try FileManager.default.moveItem(at: audioURL, to: destinationURL)
            audio_path = audioURL.absoluteString
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
}
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
        
    }

