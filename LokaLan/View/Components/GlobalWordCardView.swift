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
    @State var isThumbsUp = false
    @State var isThumbsDown = false
    @State var word: WordData
    @ObservedObject var player = AudioPlayer()
    @StateObject private var wordViewmodel = WordViewModel.shared
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack {
                        VStack {
                            HStack {
                                Text("\(word.word)").font(.title.weight(.bold))
                                Spacer()
                            }
                            HStack {
                                Text("\(word.meaning)").font(.headline.weight(.light))
                                Spacer()
                            }
                        }
                        Spacer()
                        VStack {
                            Button{
                                player.playOnlineAudio(url: word.audio_path ?? "")
                                print(word.audio_path ?? "")
                            }label: {
                                Image(systemName: player.isPlaying ?"speaker.wave.2.circle.fill" : "speaker.wave.2.circle").resizable().frame(width: 40,height: 40).foregroundColor(Color("Blue"))
                            }
                            Spacer()
                        }
                    }
                    
                    Text("by \(word.username)").font(.footnote.weight(.light)).padding(.top,5)
                    HStack{
                        HStack {
                            Button{
                                if(UserViewModel.shared.id != 0){
                                    if(word.hasLiked == "false"){
                                        WordViewModel.shared.createWordLike(wordId: String(word.id), like: true)
                                    }else if(word.hasLiked == "hated"){
                                        WordViewModel.shared.updateWordLike(wordId: String(word.id), like: true)
                                    }else{
                                        WordViewModel.shared.deleteWordLike(wordId: String(word.id))
                                    }
                                }
                            }label: {
                                Image(systemName: word.hasLiked == "liked" ? "hand.thumbsup.fill" : "hand.thumbsup").resizable().frame(width: 15,height: 15).foregroundColor(Color("Blue"))
                            }
                            Text("\(word.upvote)").font(.footnote).foregroundColor(Color("Blue"))
                            
                            Text("|").font(.title2.weight(.light)).padding(.horizontal, 5).foregroundColor(.gray)
                            
                            Button{
                                if(UserViewModel.shared.id != 0){
                                    if(word.hasLiked == "false"){
                                        WordViewModel.shared.createWordLike(wordId: String(word.id), like: false)
                                    }else if(word.hasLiked == "liked"){
                                        WordViewModel.shared.updateWordLike(wordId: String(word.id), like: false)
                                    }else{
                                        WordViewModel.shared.deleteWordLike(wordId: String(word.id))
                                    }
                                }
                            }label: {
                                Image(systemName: word.hasLiked == "hated" ? "hand.thumbsdown.fill" : "hand.thumbsdown").resizable().frame(width: 15,height: 15)
                            }
                            Text("\(word.downvote)").font(.footnote)
                        }
                        .padding(5)
                        .padding(.horizontal, 10)
                        .background(Color("LightGray"))
                        .cornerRadius(5)
                        
                        Spacer()
                        if(word.user_id == UserViewModel.shared.id){
                            SmallButton(label: "Lokal", systemImage: "plus", color: Color("Blue"), is_activated: WordViewModel.shared.getWordByPublishedID(id: word.id)){
                                showingDeleteAlert = true
                            }        .alert(WordViewModel.shared.getWordByPublishedID(id: word.id) ? "Hapus dari lokal ?" : "Tambahkan ke Lokal", isPresented: $showingDeleteAlert) {
                                Button("Ya", role: .destructive) {
                                    if(!WordViewModel.shared.getWordByPublishedID(id: word.id)){
                                        WordViewModel.shared.addWordToLocalLibrary(wordData: word)
                                        WordViewModel.shared.getAllWords()
                                        showingDeleteAlert = false
                                    }else{
                                        WordViewModel.shared.delete(word: WordViewModel.shared.getWordModelByPublishedID(id: word.id))
                                        WordViewModel.shared.getAllWords()
                                        showingDeleteAlert = false
                                    }
                                }
                                Button("Tidak", role: .cancel) {
                                    showingDeleteAlert = false

                                }
                            }
                        }else{
                            SmallButton(label: "Hapus", systemImage: "trash", color: Color.red, is_activated: dummyBool){
                                WordViewModel.shared.UnpublishWord(id: word.id) { bool in
                                    
                                }
                            }
                        }
                
                    }
                }.foregroundColor(.black)
                Spacer()

              
            }.padding(.bottom,15)
            HStack{
                
            }.font(.footnote).bold()
        }.padding(20).background(.white).cornerRadius(10).shadow(radius: 0.3)
    }
}


