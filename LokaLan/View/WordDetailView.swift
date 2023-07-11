//
//  WordDetailView.swift
//  cobaCoreML
//
//  Created by Andreas Lim on 23/06/23.
//

import SwiftUI
import AVFoundation
struct WordDetailView: View {
    @State var isEdit = false
    var word:WordModel
    
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
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        isEdit = true
                    }) {
                        Text("Ubah")
                        
                    }.foregroundColor(Color(.white)).sheet(isPresented: $isEdit){
                        WordAddEditView(word: word)
                    }
                    
                }
            }
                    
            VStack {
                ZStack {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack{
                                Text("\(word.name)")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color(.black))
                                Button(action: {
                                    print(word.audio_path)
                                    AudioPlayer.shared.playAudio(url: word.audio_path)
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
                        Text("\(word.usage_examples)")
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
