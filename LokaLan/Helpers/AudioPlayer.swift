//
//  AudioPlayer.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 01/07/23.
//

import AVFoundation
import SwiftUI

class AudioPlayer: ObservableObject{
    private var player: AVPlayer?
    @Published var isPlaying: Bool = false
    static let shared = AudioPlayer()
    func playAudio(url:String) {
        guard let url = URL(string: "\(url)") else {
            return
        }

        let playerItem = AVPlayerItem(url: url)
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        isPlaying = true
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        
    }
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        isPlaying = false
    }
    
}
