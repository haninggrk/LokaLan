//
//  WordDetailView.swift
//  cobaCoreML
//
//  Created by Andreas Lim on 23/06/23.
//

import SwiftUI
import AVFoundation
struct WordDetailView: View {
    var word:WordModel
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
                .padding(.bottom, 150)
                .background(
                    CustomCorners(color: LinearGradient(gradient: Gradient(colors: [Color("BgBlue"),Color("BgPurple")]), startPoint: .top, endPoint: .bottom), tl: 0, tr: 0, bl: 120, br: 120)
                )
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        
                    }) {
                        Label("Profile", systemImage: "person.crop.circle")
                    }.foregroundColor(Color(.white))
                }
            }
            
            VStack {
                ZStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(word.name)")
                                .font(.title)
                                .bold()
                                .foregroundColor(Color(.black))
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
                    .frame(width: 340, height: 110)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.horizontal,10)
                    
                    Button(action: {
                        print(word.audio_path)
                        playAudio(url: word.audio_path)
                    }) {
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(Color("BgPurple2"))
                                    .frame(width: 78, height: 78)
                                Circle()
                                    .fill(Color("BgOrange"))
                                    .frame(width: 68, height: 68)
                                Image(systemName: "speaker.wave.2")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 22, height: 22)
                                    .bold()
                            }
                        }
                        .padding(.bottom,50)
                    }
                    .foregroundColor(Color(.black))
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(word.meaning)")
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
                        Text("1. “kamu kemana aja?” —— “kon nang ndi ae”")
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
                Spacer()
            }
            .padding(.leading)
            .padding(.trailing, 20)
            .padding(.top, 100)
        }
        .background(Color("BgWhite"))
    }
}

struct CustomCorners: View {
    var color: LinearGradient
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}

struct WordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WordDetailView(word:WordViewModel.shared.words[0])
    }
}
