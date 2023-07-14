//
//  WordLibraryView.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 26/06/23.
//

import SwiftUI
import AVFoundation
struct WordLibraryView: View {
    @State private var selectedMenu = "Lokal"
    @State private var isAddWord = false
    @State private var isEditWord = false
    @State private var isOpenProfile = false
    @State private var isOpenSpeech = false
    @State private var isOpenFilter = false
    @StateObject private var wordList = WordViewModel.shared
    @State private var isAddingWord = false
    @State var submenu: Int = 0
    var body: some View {
        VStack {
            VStack{

                VStack(alignment: .leading){
                    Text("Kosakata").font(.largeTitle.weight(.bold)).foregroundColor(.white).padding(.bottom,-1)
                    HStack {
                        SearchView(searchText: $wordList.searchText)
                        
                        Button(action: {
                            isOpenFilter = true
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 20, height: 18)
                                .padding(.leading, 10)
                        }
                        .foregroundColor(Color(.white))
                        .sheet(isPresented: $isOpenFilter){
                            WordAddEditView(tempWord: wordList)
                        }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
                SegmentControlView(submenu: $submenu)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("BgBlue"),Color("BgPurple")]), startPoint: .top, endPoint: .bottom)
            )
            
            ScrollView {
                VStack{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                        if(submenu == 0){
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
                                ForEach(wordList.filteredWordList, id: \.self) {word in
                                    NavigationLink(){
                                        WordDetailView(word: word)
                                    }label:{
                                        WordCardView(word:word)
                                    }.padding(.vertical,3)
                                }
                            }
                        }else{
                            
                            
                            if(WordViewModel.shared.isLoading){
                                ProgressView("Menunggu...")
                            }else{
                                ForEach(wordList.filteredFetchedWords, id: \.self) {word in
                                    NavigationLink(){
                                        GlobalWordDetailView(word: word)
                                    }label: {
                                        GlobalWordCardView(word: word)
                                    }
                                }
                            }
                            
                            
                        }
                        
                    }.navigationDestination(for: WordModel.self) { word in
                        WordDetailView(word: word)
                        
                        
                    }.navigationDestination(for: WordData.self) { word in
                        GlobalWordDetailView(word: word)}
                    
                    
                    .padding(.horizontal,32)
                        .onChange(of: wordList.searchText, perform: { newValue in
                            
                            wordList.filterWordList()
                            wordList.filterFetchedWordList()
                            
                        }).onAppear{
                            wordList.filterWordList()
                            wordList.filterFetchedWordList()
                            
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
                    WordAddEditView(tempWord: wordList).environment(\.colorScheme, .light)
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
                    if(UserViewModel.shared.id != 0){
                        ProfileView() .environment(\.colorScheme, .light)
                            .presentationDetents([.large])
                    }else{
                        SignUpView().environment(\.colorScheme, .light)
                            .presentationDetents([.large])
                    }
                    
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
