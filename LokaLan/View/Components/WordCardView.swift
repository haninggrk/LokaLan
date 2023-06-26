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
        VStack {
            ZStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(word.name)")
                            .font(.title3)
                            .foregroundColor(Color(.black))
                            .bold()
                        Text("\(word.meaning)")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .padding(.horizontal)
                    .padding(.bottom)
                    Spacer()
                }
                .frame(width: 320, height: 80)
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal,10)
                .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
                
               
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color("BgWhite"))
                                .frame(width: 58, height: 58)
                            Circle()
                                .fill(Color("BgOrange"))
                                .frame(width: 48, height: 48)
                            Image(systemName: "speaker.wave.2")
                                .bold()
                        }.onTapGesture {
                            print("hllo")
                            playAudio(url: word.audio_path)
                        }
                    }
                    .padding(.bottom,40)
                
                .foregroundColor(Color(.black))
                
            }
        }
        .padding(.leading)
        .padding(.trailing, 30)
    }
}


