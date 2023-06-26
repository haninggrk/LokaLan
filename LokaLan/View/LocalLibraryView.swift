//
//  LocalLibraryView.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 22/06/23.
//

import SwiftUI

struct LocalLibraryView: View {
    @StateObject private var wordList = WordViewModel.shared
    @State private var isAddingWord = false
    @State private var submenu = 0 
    var body: some View {
        
        NavigationStack(){
            VStack{
           
                Button{
                    isAddingWord = true
                }label: {
                    Text("Add Word")

                }
                
                Picker("submenu", selection: $submenu){
                    Text("Local").tag(0)
                    Text("Global").tag(1)
                }.pickerStyle(.segmented)
                if(submenu == 0){
                    
                    
                    List{
                        ForEach(wordList.words, id: \.id){ word in
                            NavigationLink(value: word){
                                HStack{
                                    Text(word.name)
                                    Text("| Desc: \(word.desc)")
                                    Spacer()
                                    Image(systemName: "x.circle").foregroundColor(.red).onTapGesture {
                                        wordList.delete(word: word)
                                        wordList.getAllWords()
                                    }
                                }
                                
                                
                            }
                        }
                    }.navigationDestination(for: WordModel.self) { word in
                        WordDetailView(word: word)
                    }
                    Button{
                        wordList.fetchWordFromAPI()
                        print(wordList.fetchedWords)
                    }label: {
                        Text("Fetch")
                        
                    }
                }else{
                    List{
                        ForEach(wordList.fetchedWords, id: \.id){ word in
                            NavigationLink(value: word){
                                HStack{
                                    Text("word: \(word.word)")
                                    Text("| Desc: \(word.description)")
                                    Spacer()
                                    Image(systemName: "x.circle").foregroundColor(.red).onTapGesture {
                             
                                        wordList.fetchWordFromAPI()
                                    }
                                }
                                
                                
                            }
                        }
                    }.onAppear{
                        wordList.fetchWordFromAPI()
                    }
            
                }

            }.sheet(isPresented: $isAddingWord, content: {
                LocalLibraryAddView()
            }).navigationTitle("Words")
        
        }
            
            
        
    }
}

struct LocalLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LocalLibraryView()
    }
}
