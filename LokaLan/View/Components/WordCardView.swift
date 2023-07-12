//
//  WordCardView.swift
//  cobaCoreML
//
//  Created by Andreas Lim on 23/06/23.
//

import SwiftUI
import AVFoundation
struct WordCardView: View {
    @State var dummyBool = false
    @State var word: WordModel
    @ObservedObject var player = AudioPlayer()
    @StateObject private var wordViewmodel = WordViewModel.shared


 
    var body: some View {
      
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("\(word.name)").font(.title.weight(.bold))
                    Text("\(word.meaning)").font(.headline.weight(.light))
                }.foregroundColor(.black)
                Spacer()
                Button{
                    player.playAudio(url: word.audio_path)
                }label: {
                    Image(systemName: player.isPlaying ?"speaker.wave.2.circle.fill" : "speaker.wave.2.circle").resizable().frame(width: 35,height: 35).foregroundColor(Color("Blue"))
                }
            }.padding(.bottom,15)
            HStack{
              
                SmallButton(label: "Widget", systemImage: "pin", color: Color("Blue"),is_activated: word.is_widget){
                    word.is_widget.toggle()
                    word.save()
                    wordViewmodel.getAllWords()
                }
                SmallButton(label: "Global", systemImage: "globe", color: Color("Blue"),is_activated: word.is_published){
                    if(word.is_published){
                        word.unpublish()
                    }else{
                        word.pushToGlobal()
                    }
                    wordViewmodel.getAllWords()
                }
                Spacer()
                SmallButton(label: "Delete", systemImage: "trash", color: Color.red, is_activated: dummyBool){
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
