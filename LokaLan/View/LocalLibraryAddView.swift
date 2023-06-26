//
//  LocalLibraryAddView.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 22/06/23.
//

import SwiftUI

struct LocalLibraryAddView: View {
    @StateObject private var wordList = WordViewModel.shared
    @State var isRecording = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack{
            TextField("Input kata",text: $wordList.name).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Input arti",text: $wordList.meaning).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Input description",text: $wordList.desc).textFieldStyle(RoundedBorderTextFieldStyle())
            Button{
                if(isRecording){
                    wordList.stopRecording()
                }else{
                    wordList.startRecording()
                }
                isRecording.toggle()
                
            
            }label: {
                Image(systemName: isRecording ? "stop": "mic").padding(5).background(.red).cornerRadius(100)
            }
            Button{
                wordList.save()
                wordList.getAllWords()
                dismiss()
            }label: {
                Text("Save").padding(10).background(.black).cornerRadius(10)
            }
        }.padding(20)

       
        
    }
}

struct LocalLibraryAddView_Previews: PreviewProvider {
    static var previews: some View {
        LocalLibraryAddView()
    }
}
