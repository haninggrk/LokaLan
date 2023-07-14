//
//  WordDetailView.swift
//  cobaCoreML
//
//  Created by Andreas Lim on 23/06/23.
//

import SwiftUI
import AVFoundation
struct GlobalWordDetailView: View {
    var vm = WordViewModel()
    var word:WordData
    
    var body: some View {
        ZStack {
            VStack{
                VStack {
                    HStack {
                        Spacer()
                        Text("Detail")
                            .foregroundColor(.white)
                            .font(.title.bold())
                            .accessibilityAddTraits(.isHeader)
                        Spacer()
                    }
                }
                .padding(.top, 80)
                .padding(.bottom, 120)
                .background(
                    CustomCorners(color: LinearGradient(gradient: Gradient(colors: [Color("BgBlue"),Color("BgPurple")]), startPoint: .top, endPoint: .bottom), tl: 0, tr: 0, bl: 100, br: 100)
                )
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

            }
                    
            VStack {
                ZStack {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack{
                                Text("\(word.word)")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color(.black))
                                Button(action: {
                                    if let audiopath = word.audio_path{
                                        AudioPlayer.shared.playAudio(url: audiopath)
                                    }
                                }) {
                                    Image(systemName: "speaker.wave.2.fill").bold()
                                }
                                .foregroundColor(Color(.blue))
                            }
                           
                            Spacer()
                            Text("\(word.meaning)")
                                .font(.body)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .padding(.horizontal)
                        .padding(.bottom)
                        Spacer()
                    }
                    .frame(height: 110)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.bottom,20)
                    .padding(.top,20)
                    .padding(.horizontal,10)
                    
         
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(word.description ?? "")")
                            .font(.body)
                            .italic()
                            .foregroundColor(.black)
                    }
                    .padding()
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 60)
                    Spacer()
                }
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal,10)
                .padding(.bottom, 10)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Contoh: ")
                            .font(.body)
                            .italic()
                            .foregroundColor(.black)
                            .padding(.bottom)
                        Text("\(word.usage_examples ?? "" )")
                            .font(.body)
                            .italic()
                            .foregroundColor(.black)
                    }
                    .padding()
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 60)
                    Spacer()
                }
                .background(.white)
                .cornerRadius(20)
                .padding(.horizontal, 10)
                Spacer()
            }
            .padding(.leading)
            .padding(.trailing, 20)
            .padding(.top, 30)
        }
        .background(Color("BgWhite"))
    }
}


