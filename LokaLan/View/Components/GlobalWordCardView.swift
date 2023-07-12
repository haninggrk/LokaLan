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
                    
                    Text("by andre02").font(.footnote.weight(.light)).padding(.top,5)
                    HStack{
                        HStack {
                            Button{
                                
                            }label: {
                                Image(systemName: isThumbsUp ?"hand.thumbsup.fill" : "hand.thumbsup").resizable().frame(width: 15,height: 15).foregroundColor(Color("Blue"))
                            }
                            Text("21").font(.footnote).foregroundColor(Color("Blue"))
                            
                            Text("|").font(.title2.weight(.light)).padding(.horizontal, 5).foregroundColor(.gray)
                            
                            Button{
                                
                            }label: {
                                Image(systemName: isThumbsDown ?"hand.thumbsdown.fill" : "hand.thumbsdown").resizable().frame(width: 15,height: 15)
                            }
                            Text("1").font(.footnote)
                        }
                        .padding(5)
                        .padding(.horizontal, 10)
                        .background(Color("LightGray"))
                        .cornerRadius(5)
                        
                        Spacer()
                        
                        SmallButton(label: "Lokal", systemImage: "plus", color: Color("Blue"), is_activated: false){
                            showingDeleteAlert = true
                        }
                        .alert("Hapus dari lokal ?", isPresented: $showingDeleteAlert) {
                            Button("Ya", role: .destructive) {
                                
                            }
                            Button("Tidak", role: .cancel) {
                                
                            }
                        }
                    }
                }.foregroundColor(.black)
            }
//            .padding(.bottom,15)
            HStack{
                
            }.font(.footnote).bold()
        }.padding(20).background(.white).cornerRadius(10).shadow(radius: 0.3)
    }
}


