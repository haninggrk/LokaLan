//
//  WordLibraryView.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 26/06/23.
//

import SwiftUI
import AVFoundation
struct WordLibraryView: View {
    @State private var searchText = ""
    @State private var selectedMenu = "Lokal"
    @State private var isAddWord = false
    @State private var isEditWord = false
    @State private var isOpenProfile = false
    @State private var isOpenSpeech = false
    @StateObject private var wordList = WordViewModel.shared
    @State private var isAddingWord = false
    @State var submenu: Int = 0
    var body: some View {
        VStack {
            VStack{
                
                VStack(alignment: .leading){
                    Text("Kosakata").font(.largeTitle.weight(.bold)).foregroundColor(.white).padding(.bottom,-1)
                    SearchView()
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
                SegmentControlView(submenu: $submenu)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("BgBlue"),Color("BgPurple")]), startPoint: .top, endPoint: .bottom)
            )
            if (wordList.words.isEmpty) {
                Spacer()
                VStack{
                    Image(systemName:"key.radiowaves.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.leading, 30)
                    
                    Text("You don’t have any word yet, add by click ‘+’ icon in the top right corner.")
                        .font(.footnote)
                        .padding(30)
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.gray)
                Spacer()
            }else{
                ScrollView {
                    VStack{
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                            if(submenu == 0){
                                ForEach(wordList.words, id: \.self) {word in
                                    NavigationLink(){
                                        WordDetailView(word: word)
                                    }label:{
                                        WordCardView(word:word)
                                    }.padding(.vertical,3)
                                }
                            }else{
                                ForEach(wordList.fetchedWords, id: \.self) {word in
                                    GlobalWordCardView(word: word)
                                }
                                
                                if(WordViewModel.shared.isLoading){
                                    ProgressView("Menunggu...")
                                }else{
                                    ForEach(wordList.fetchedWords, id: \.self) {word in
                                        GlobalWordCardView(word: word)
                                    }
                                }
                                
                                
                            }
                            
                        }.navigationDestination(for: WordModel.self) { word in
                            WordDetailView(word: word)
                                .onAppear{
                                    print(wordList.fetchedWords)
                                    
                                }
                            
                        }.padding(.horizontal,32)
                    }
                }
            }
        }
        .background(Color("BgWhite"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    isAddWord = true
                    
                }) {
                    Label("AddWord", systemImage: "plus")
                }
                .foregroundColor(Color(.white))
                .sheet(isPresented: $isAddWord){
                    WordAddEditView(tempWord: wordList)
                }
            }
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    isOpenProfile = true
                }) {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .foregroundColor(Color(.white))
                .sheet(isPresented: $isOpenProfile){
                    ProfileView()
                    
                }
            }
        }
        //        .navigationTitle("My Home")
        .onOpenURL(perform: { (url) in
            self.isAddWord = url == URL(string: "game:///link1")!
            self.isOpenProfile = url == URL(string: "game:///link2")!
        })
    }
}

struct WordLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        WordLibraryView()
    }
}
