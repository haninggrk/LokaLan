//
//  WordCardView.swift
//  cobaCoreML
//
//  Created by Andreas Lim on 23/06/23.
//

import SwiftUI
import AVFoundation
struct GlobalWordCardView: View {
    @State var dummyBool = false
    @State var word: WordData
    @ObservedObject var player = AudioPlayer()
    @StateObject private var wordViewmodel = WordViewModel.shared


 
    var body: some View {
      
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("\(word.word)").font(.title.weight(.bold))
                    Text("\(word.meaning)").font(.headline.weight(.light))
                }.foregroundColor(.black)
                Spacer()
                Button{
                    player.playAudio(url: word.audio_path ?? "")
                }label: {
                    Image(systemName: player.isPlaying ?"speaker.wave.2.circle.fill" : "speaker.wave.2.circle").resizable().frame(width: 35,height: 35).foregroundColor(.blue)
                }
            }.padding(.bottom,15)
            HStack{
              

            }.font(.footnote).bold()
        }.padding(20).background(.white).cornerRadius(10).shadow(radius: 1)
    }
}


