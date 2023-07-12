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
    @State private var showingDeleteAlert = false
    @State private var showingUnpublishedAlert = false
    
    var body: some View {
        
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("\(word.name)").font(.title.weight(.bold)).padding(.bottom,4)
                    Text("\(word.meaning)").font(.title3.weight(.light))
                }.foregroundColor(.black)
                Spacer()
                VStack {
                    Button{
                        player.playAudio(url: word.audio_path)
                    }label: {
                        Image(systemName: player.isPlaying ?"speaker.wave.2.circle.fill" : "speaker.wave.2.circle").resizable().frame(width: 40,height: 40).foregroundColor(Color("Blue"))
                    }
                    Spacer()
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
                        showingUnpublishedAlert = true
                    }else{
                        word.pushToGlobal()
                    }
                    wordViewmodel.getAllWords()
                }
                .alert("Batalkan Publikasi ?", isPresented: $showingUnpublishedAlert) {
                    Button("Ya", role: .destructive) {
                        word.unpublish()
                    }
                    Button("Tidak", role: .cancel) {
                        
                    }
                }
                Spacer()
                SmallButton(label: "Hapus", systemImage: "trash", color: Color.red, is_activated: dummyBool){
                    showingDeleteAlert = true
                }
                .alert("Anda yakin ingin menghapus ?", isPresented: $showingDeleteAlert) {
                    Button("Ya", role: .destructive) {
                        WordViewModel.shared.delete(word: word)
                        WordViewModel.shared.getAllWords()
                    }
                    Button("Tidak", role: .cancel) {
                        
                    }
                }
                
                
                
            }.font(.footnote).bold()
        }.padding(20).background(.white).cornerRadius(10).shadow(radius: 0.3)
    }
}


//struct WordCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            WordCardView().padding(32)
//        }
//    }
//}
