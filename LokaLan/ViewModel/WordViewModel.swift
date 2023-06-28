//
//  WordViewModel.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 22/06/23.
//

import Foundation
import AVFoundation
import CoreData

class WordViewModel: ObservableObject{
    var timer:Timer = Timer()
    private var currentSample: Int
    private let numberOfSamples = 20
    
    @Published var audioRecorder: AVAudioRecorder?
    @Published var words: [WordModel] = []
    @Published var fetchedWords:[WordData] = []
    @Published public var soundSamples: [Float]
    
    

    
    
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
    

    func save(){
        let word = Word(context: CoreDataManager.shared.viewContext)
    
        word.word = name
        word.meaning = meaning
        word.desc = desc
        word.audio_path = audio_path
        word.downvote = downvote
        word.upvote = upvote
        word.is_local = true;
        word.is_published = false;
        CoreDataManager.shared.save()
    }
    init(){

        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0
        getAllWords()
        fetchWordFromAPI()
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
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            startMonitoring()
        } catch {
            print("Failed to create audio recorder: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        timer.invalidate()
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
    struct APIResponse: Codable {
        let success: Bool
        let data: [WordData]
    }

    private func startMonitoring() {
     
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (timer) in
            // 7
            self.audioRecorder?.updateMeters()
            self.soundSamples[self.currentSample] = (self.audioRecorder?.averagePower(forChannel: 0))!
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
        })
    }
    
    
        
        
    func fetchWordFromAPI() {
        let url = "http://127.0.0.1:8000/words/"
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let jsonData = data else {
                print("No data received")
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                DispatchQueue.main.async {
                    print("Received API response:")
                    print(apiResponse)
                    self.fetchedWords = apiResponse.data
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
            
        }.resume()
    }
 







    
    
    
}


