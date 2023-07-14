//
//  AudioDownloader.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 13/07/23.
//

import Foundation

func downloadAudioFromURL(_ url: URL, completion: @escaping (URL?) -> Void) {
    let destinationURL = getDocumentsDirectory().appendingPathComponent("audio.wav")
    let task = URLSession.shared.downloadTask(with: url) { (location, _, error) in
        if let error = error {
            print("Error downloading audio file: \(error)")
            completion(nil)
            return
        }
        
        guard let location = location else {
            print("Invalid file location")
            completion(nil)
            return
        }
        
        do {
            try FileManager.default.moveItem(at: location, to: destinationURL)
            completion(destinationURL)
        } catch {
            print("Error moving audio file to destination: \(error)")
            completion(nil)
        }
    }
    
    task.resume()
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
