//
//  LocalLibraryAddView.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 22/06/23.
//

import SwiftUI

struct WordAddEditView: View {

    @StateObject private var wordList = WordViewModel.shared
    @State var isRecording = false
    @Environment(\.dismiss) private var dismiss
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.5, CGFloat(level) + 30) / 2 // between 0.1 and 25
        
        return CGFloat(level * (150 / 25)) // scaled to max at 300 (our height of our bar)
    }
    var body: some View {
        NavigationView{
            
            VStack(alignment:.leading){
                Group{
                    Text("Kata").bold()
                    CustomTextField(text: $wordList.name, placeholder: "masukkan kata")
                    Text("Arti").bold()
                    CustomTextField(text: $wordList.meaning, placeholder: "masukkan penjelasan kata")
                    Text("Definisi").bold()
                    CustomTextEditor(text: $wordList.desc)
                    Text("Contoh").bold()
                    CustomTextEditor(text: $wordList.desc)
                    HStack() {
                        Spacer()
                        ForEach(wordList.soundSamples, id: \.self) { level in
                            BarView(value: self.normalizeSoundLevel(level: level))
                        }
                        Spacer()
                        Button{
                            if(isRecording){
                                wordList.stopRecording()
                            }else{
                                wordList.startRecording()
                         
                            }
                            isRecording.toggle()
                            
                            
                        }label: {
                            Image(systemName: isRecording ? "stop": "mic").resizable().frame(width:  isRecording ? 30:20,height: 30).padding(5).background(.clear).cornerRadius(100)
                        }
                        Spacer()
                    }.padding(10).background(Color("LightGray")).cornerRadius(20)
                    
                    
                }
              
      

            
                
                Spacer()
                
                
            }.padding(20)
            
                .toolbar{
                    
                    ToolbarItem(placement:.primaryAction ){
                        Button{
                            wordList.save()
                            wordList.getAllWords()
                            dismiss()
                        }label:{
                            Text("Simpan").bold().foregroundColor(Color(.blue))
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        ZStack {
                            
                            Text("Tambah")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.primary)
                        }
                    }
                    ToolbarItem(placement:.cancellationAction ){
                        Text("Batal").bold().foregroundColor(Color(.blue))
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
        WordAddEditView()
    }
}
