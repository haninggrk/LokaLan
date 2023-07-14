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
        VStack {
            ModalsBar()
            NavigationView{
                ScrollView {
                    VStack(alignment:.leading){
                        Group{
                            VStack {
                                HStack {
                                    Text("Kata").font(.subheadline).bold()
                                    Spacer()
                                }
                                ZStack{
                                    CustomTextField(text:  $tempWord.name, placeholder: "Masukkan kata")
                                    HStack{
                                        Spacer()
                                        Image(systemName: "speaker.wave.2.circle").padding(10).foregroundColor(.gray)
                                    }
                                }
                            }.padding(.bottom, 15)
                            VStack {
                                HStack {
                                    Text("Arti").font(.subheadline).bold()
                                    Spacer()
                                }
                                CustomTextField(text: $tempWord.meaning, placeholder: "Masukkan arti kata")
                            }.padding(.bottom, 15)
                            VStack {
                                HStack {
                                    Text("Definisi").font(.subheadline).bold()
                                    Spacer()
                                }
                                CustomTextEditor(text: $tempWord.desc,placeholderString: "Masukkan definisi kata")
                            }.padding(.bottom, 15)
                            VStack {
                                HStack {
                                    Text("Contoh").font(.subheadline).bold()
                                    Spacer()
                                }
                                CustomTextEditor(text: $tempWord.usage_examples,placeholderString: "Masukkan contoh penggunaan kata")
                            }.padding(.bottom, 15)
                            
                            HStack {
                                Spacer()
                                Button{
                                    if(isRecording){
                                        tempWord.stopRecording()
                                    }else{
                                        tempWord.startRecording()
                                        
                                    }
                                    isRecording.toggle()
                                }
                            label: {
                                Image(systemName: isRecording ? "stop": "mic.circle.fill")
                                    .resizable()
                                    .frame(width: isRecording ? 40:60,height: isRecording ? 40:60)
                                    .padding()
                                    .cornerRadius(100)
                                    .foregroundColor(Color("Blue"))
                            }
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal)
                    .toolbar{
                        ToolbarItem(placement:.primaryAction ){
                            Button{
                                tempWord.save()
                                wordList.getAllWords()
                                dismiss()
                            }label:{
                                Text("Simpan").foregroundColor(tempWord.name == "" || tempWord.meaning == "" ? .gray : Color("Blue"))
                            }.disabled(tempWord.name == "" || tempWord.meaning == "")
                        }
                        ToolbarItem(placement:.cancellationAction ){
                            Button{
                                dismiss()
                            }label: {
                                Text("Batal").foregroundColor(Color("Blue"))
                            }
                        }
                    }
                    .navigationTitle("Tambah")
                  
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}



struct WordAddEditView_Previews: PreviewProvider {
    static var previews: some View {
        WordAddEditView(tempWord: WordViewModel.shared)
    }
}
