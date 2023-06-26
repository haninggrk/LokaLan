//
//  WordDetailView.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 23/06/23.
//

import SwiftUI
import AVFoundation
struct WordDetailView: View {
    @State private var player: AVPlayer?
    func playAudio(url:String) {
        guard let url = URL(string: "\(url)") else {
            return
        }

        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    
    var word:WordModel
    var body: some View {
        VStack{
            Text("\(word.name)")
            Text("\(word.desc)")
            Text("Downvote: \(word.downvote)")
            Text("Upvote: \(word.upvote)")
            Button{
                playAudio(url: word.audio_path)
            }label: {
                Image(systemName: "speaker").padding(10).background(.red)
            }
        }.onAppear{
            print(word.audio_path)
        }
    }
}

//struct WordDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WordDetailView(word: WordModel(word: <#T##Word#>))
//    }
//}
