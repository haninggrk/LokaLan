//
//  LocalLibraryAddView.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 22/06/23.
//

import SwiftUI

struct WordAddEditView: View {
    
    //@StateObject private var tempWord = WordViewModel()
    @ObservedObject var tempWord: WordViewModel
    @StateObject private var wordList = WordViewModel.shared
    @State var isRecording = false
    @Environment(\.dismiss) private var dismiss
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.5, CGFloat(level) + 30) / 2 // between 0.1 and 25
        
        return CGFloat(level * (150 / 25)) // scaled to max at 300 (our height of our bar)
    }
    
//    init(word:WordModel? = nil){
//        if let word = word{
//            print("isi", word.name)
//            tempWord.name = word.name
//            tempWord.desc = word.desc
//            tempWord.meaning = word.meaning
//            tempWord.usage_examples = word.usage_examples
//        } else {
//            print("isi2")
//        }
//    }

    var body: some View {
        NavigationView{
            
            VStack(alignment:.leading){
                Group{
                    Text("Kata").bold()
                    ZStack{
                        CustomTextField(text:  $tempWord.name, placeholder: "Masukkan kata")
                        HStack{
                         Spacer()
                            Image(systemName: "speaker.wave.2.circle").padding(10).foregroundColor(.gray)
                        }
                    }
                    Text("Arti").bold()
                    CustomTextField(text: $tempWord.meaning, placeholder: "Masukkan arti kata")
                    Text("Definisi").bold()
                    CustomTextEditor(text: $tempWord.desc,placeholderString: "Masukkan definisi kata")
                    Text("Contoh").bold()
                    CustomTextEditor(text: $tempWord.usage_examples,placeholderString: "Masukkan contoh penggunaan kata")
                    
                    HStack() {
                        Spacer()
                        ForEach(tempWord.soundSamples, id: \.self) { level in
                            BarView(value: self.normalizeSoundLevel(level: level))
                        }
                        Spacer()
                        Button{
                            if(isRecording){
                                tempWord.stopRecording()
                            }else{
                                tempWord.startRecording()
                                
                            }
                            isRecording.toggle()
                            
                            
                        }label: {
                            Image(systemName: isRecording ? "stop": "mic").resizable().frame(width:  isRecording ? 30:20,height: 30).padding(5).background(.clear).cornerRadius(100)
                        }
                        Spacer()
                    }.padding(10
                    )
                    .frame(maxHeight: 100)
                    
                    .background(Color("LightGray")
                    ).cornerRadius(20).padding(.top,10)
                    
                    
                }
                
                
                
                
                
                Spacer()
                
                
            }.padding(20)
            
            
                .toolbar{
                    
                    ToolbarItem(placement:.primaryAction ){
                        Button{
                            tempWord.save()
                            wordList.getAllWords()
                            dismiss()
                        }label:{
                            Text("Simpan").bold().foregroundColor(Color(tempWord.name == "" || tempWord.meaning == "" ? .gray : .blue))
                        }.disabled(tempWord.name == "" || tempWord.meaning == "")
                    }
                    ToolbarItem(placement: .principal) {
                        ZStack {
                            
                            Text("Tambah")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.primary)
                        }
                    }
                    ToolbarItem(placement:.cancellationAction ){
                        Button{
                            dismiss()
                        }label: {
                            Text("Batal").bold().foregroundColor(Color(.blue))
                        }
                    }
                    
                    
                }.navigationBarTitleDisplayMode(.inline)
        }
        
        
        
    }
    struct BarView: View {
        var value: CGFloat
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(width: (UIScreen.main.bounds.width - CGFloat(20) * 11) / CGFloat(30), height: value)
            }
        }
    }
    
}



struct WordAddEditView_Previews: PreviewProvider {
    static var previews: some View {
        WordAddEditView(tempWord: WordViewModel.shared)
    }
}
