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
    @Published var isLoading = false
    @Published var audioRecorder: AVAudioRecorder?
    @Published var words: [WordModel] = []
    @Published var fetchedWords:[WordData] = []
    @Published public var soundSamples: [Float]
    @Published var is_local = true
    @Published var is_published = false
    @Published var is_widget = false
    static var shared:WordViewModel = WordViewModel()
    @Published var usage_examples: String = ""
    @Published var name: String = ""
    @Published var meaning: String = ""
    @Published var desc: String = ""
    var audio_path: String = ""
    var downvote: Int32 = 0
    var upvote: Int32 = 0
    var audioURL: URL?
    var fileName: String = ""
    func getAllWords(){
        words = CoreDataManager.shared.getAllWords().map(WordModel.init)
    }
    
    func addWordToLocalLibrary(wordData: WordData) {
        let word = Word(context: CoreDataManager.shared.viewContext)
        word.word = wordData.word
        word.meaning = wordData.meaning
        word.desc = wordData.description
        
        word.downvote = Int32(wordData.downvote)
        word.upvote = Int32(wordData.upvote)
        word.is_local = true
        word.published_id = Int32(wordData.id)
        
        if let audioURLString = wordData.audio_path {
            // Remove "optional" and single quotes from the string
            let cleanedURLString = audioURLString.replacingOccurrences(of: "Optional('", with: "").replacingOccurrences(of: "')", with: "")
            if let audioURL = URL(string: "https://lokalan.curiousgalih.biz.id/uploads/\(cleanedURLString)") {
                downloadAudioFromURL(audioURL) { localURL in
                    if let localURL = localURL {
                        word.audio_path = localURL.absoluteString
                    } else {
                        word.audio_path = ""
                    }
                    
                    CoreDataManager.shared.save()
                }
            } else {
                word.audio_path = ""
                CoreDataManager.shared.save()
            }
        } else {
            word.audio_path = ""
            CoreDataManager.shared.save()
        }
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
        CoreDataManager.shared.save()
    }

    
    init(){
        self.soundSamples = [Float](repeating: -20, count: numberOfSamples)
        self.currentSample = 0
        getAllWords()
    }

    
    func delete(word:WordModel){
        let existingWord = CoreDataManager.shared.getWordById(id: word.id)
        if(word.is_published){
            self.UnpublishWord(id: Int(word.published_id)) { success in
                if(success){
                    CoreDataManager.shared.deleteWord(word: existingWord!)
                    self.getAllWords()
                }
            }
        }else{
            CoreDataManager.shared.deleteWord(word: existingWord!)
            self.getAllWords()
        }

    }
    
    func update(word: WordModel) {
        let existingWord = CoreDataManager.shared.getWordById(id: word.id)
        if let existingWord = existingWord {
            existingWord.word = word.name
            existingWord.meaning = word.meaning
            existingWord.desc = word.desc
            existingWord.audio_path = word.audio_path
            existingWord.downvote = word.downvote
            existingWord.upvote = word.upvote
            existingWord.is_local = word.is_local
                
            CoreDataManager.shared.save()
        }
    }
    
    
    func startRecording() {
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
        fileName = UUID().uuidString + ".wav"
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
        print(audioURL)
        do{
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsDirectory.appendingPathComponent(fileName)
            print(destinationURL)
//            try! FileManager.default.removeItem(at: destinationURL)
//            try FileManager.default.moveItem(at: audioURL, to: destinationURL)
            audio_path = audioURL.absoluteString
         
            
        }catch{
            print(error.localizedDescription)
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session: \(error.localizedDescription)")
        }
    }


    private func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (timer) in
            self.audioRecorder?.updateMeters()
            self.soundSamples[self.currentSample] = (self.audioRecorder?.averagePower(forChannel: 0))!
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
        })
    }
    
//    func pushToGlobal(word:WordModel, completionHandler:@escaping (Int32) -> Void) {
//        let url = "https://lokalan.curiousgalih.biz.id/words"
////        let url = "http://127.0.0.1:8000/words/"
//
//        guard let apiURL = URL(string: url) else {
//            print("Invalid URL")
//            return
//        }
//        var request = URLRequest(url: apiURL)
//        request.httpMethod = "POST"
//
//        // Set the request body parameters
//        let parameters: [String: Any] = [
//            "word": word.name,
//            "meaning": word.meaning,
//            "description": "Test",
//            "user_id": 1
//        ]
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else {
//            print("Error creating request body")
//            return
//        }
//
//        request.httpBody = httpBody
//
//        let session = URLSession(configuration: .default)
//        session.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//
//            guard let jsonData = data else {
//                print("No data received")
//                return
//            }
//            do {
//                print("RESPONSE PENTING: \(String(data:jsonData, encoding: String.Encoding.utf8))")
//                let apiResponse = try JSONDecoder().decode(WordCreateAPIResponse.self, from: jsonData)
//                DispatchQueue.main.async {
//                    print("Received API response:")
//                    print(apiResponse)
//                    completionHandler(Int32(apiResponse.data.id))
//
//                }
//            } catch {
//                print("ERROR PERTAMAL: \(error)")
//                do{
//                    let apiResponse = try JSONDecoder().decode(ErrorAPIResponse.self, from: jsonData)
//                    DispatchQueue.main.async {
//                        print("Received API response:")
//                        print(apiResponse)
//                    }
//                }catch{
//                    print("Error decoding ERROR JSON: \(error)")
//                }
//            }
//
//        }.resume()
//    }
    func pushToGlobal(word: WordModel, completionHandler: @escaping (Int32) -> Void) {
        let url = "https://lokalan.curiousgalih.biz.id/words"
        // let url = "http://127.0.0.1:8000/words/"
        
        guard let apiURL = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        
        // Set the request body parameters
        let parameters: [String: Any] = [
            "word": word.name,
            "meaning": word.meaning,
            "description": "Test",
            "user_id": 1
        ]
        
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = createRequestBody(with: parameters, audioFilePath: word.audio_path, boundary: boundary) else {
            print("Error creating request body")
            return
        }

        request.httpBody = httpBody
        
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
                print("RESPONSE PENTING: \(String(data: jsonData, encoding: .utf8) ?? "")")
                let apiResponse = try JSONDecoder().decode(WordCreateAPIResponse.self, from: jsonData)
                
                DispatchQueue.main.async {
                    print("Received API response:")
                    print(apiResponse)
                    completionHandler(Int32(apiResponse.data.id))
                }
            } catch {
                print("ERROR PERTAMAL: \(error)")
                
                do {
                    let apiResponse = try JSONDecoder().decode(ErrorAPIResponse.self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        print("Received API response:")
                        print(apiResponse)
                    }
                } catch {
                    print("Error decoding ERROR JSON: \(error)")
                }
            }
        }.resume()
    }

    private func createRequestBody(with parameters: [String: Any], audioFilePath: String, boundary: String) -> Data? {
        var body = Data()
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
            var audioData:Data = try! Data(contentsOf:URL(string:audioFilePath)!)
            print(audioData)
            let audioFileName = (audioFilePath as NSString).lastPathComponent
            let audioMimeType = "audio/wav"
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"audio\"; filename=\"\(audioFileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(audioMimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(audioData)
            body.append("\r\n".data(using: .utf8)!)
      
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }

    func UnpublishWord(id:Int, completionHandler:@escaping (Bool) -> Void){
        let url = "https://lokalan.curiousgalih.biz.id/words/\(id)"
        guard let apiURL = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "DELETE"
        
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
                let apiResponse = try JSONDecoder().decode(WordDeleteAPIResponse.self, from: jsonData)
                DispatchQueue.main.async {
                    print("Received API response:")
                    print(apiResponse)
                    completionHandler(true)
                }
                
            } catch {
                do{
                    let apiResponse = try JSONDecoder().decode(ErrorAPIResponse.self, from: jsonData)
                    DispatchQueue.main.async {
                        print("Received API response:")
                        print(apiResponse)
                    }
                }catch{
                    print("Error decoding JSON: \(error)")
                }
            }
            
        }.resume()
    }
    
    
    
    func fetchWordFromAPI() {
        isLoading = true
        let url = "https://lokalan.curiousgalih.biz.id/words"
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
//            defer {
//                     DispatchQueue.main.async {
//                         self.isLoading = false
//                     }
//                 }
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let jsonData = data else {
                print("No data received")
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(WordAPIResponse.self, from: jsonData)
                DispatchQueue.main.async {
                    
                    print("Received API response:")
                    print(apiResponse)
                    self.fetchedWords = apiResponse.data
                    self.isLoading = false

                }
            } catch {
            
                    print("Error decoding JSON: \(error)")
              
            }
            
            
        }.resume()
    }
    
    
    
    
}


