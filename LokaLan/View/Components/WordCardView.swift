//
//  WordCardView.swift
//  cobaCoreML
//
//  Created by Andreas Lim on 23/06/23.
//

import SwiftUI
import AVFoundation
struct WordCardView: View {
    var word: WordModel
    @State private var player: AVPlayer?
    
    func playAudio(url:String) {
        guard let url = URL(string: "\(url)") else {
            return
        }

        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    var body: some View {
      
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("\(word.name)").font(.title.weight(.bold))
                    Text("\(word.meaning)").font(.headline.weight(.light))
                }.foregroundColor(.black)
                Spacer()
                Button{
                    playAudio(url: word.audio_path)
                }label: {
                    Image(systemName: "speaker.wave.2.circle").resizable().frame(width: 35,height: 35).foregroundColor(.blue)
                }
            }.padding(.bottom,15)
            HStack{
              
                SmallButton(label: "Widget", systemImage: "pin", color: Color.blue){
                    
                }
                SmallButton(label: "Global", systemImage: "globe", color: Color.blue){
                    
                }
                Spacer()
                SmallButton(label: "Delete", systemImage: "trash", color: Color.red){
                    WordViewModel.shared.delete(word: word)
                    WordViewModel.shared.getAllWords()
                }
                
                
            }.font(.footnote).bold()
        }.padding(20).background(.white).cornerRadius(10).shadow(radius: 1)
    }
}


//struct WordCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            WordCardView().padding(32)
//        }
//    }
//}
