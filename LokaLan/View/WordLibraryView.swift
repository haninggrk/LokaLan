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
    //    @State private var words = []
    @StateObject private var wordList = WordViewModel.shared
    @State private var isAddingWord = false
    @State var submenu: Int = 0
    @State private var selectedFilter: String = "A-Z"
    let filter = ["A-Z", "Terbaru", "Popularitas", "Global"]
    
    var body: some View {
        VStack {
            VStack{
                VStack(alignment: .leading){
                    Text("Kosakata").font(.largeTitle.weight(.bold)).foregroundColor(.white).padding(.bottom,-1)
                    HStack {
                        SearchView(searchText: $wordList.searchText)
                        
                        Menu {
                            ForEach(filter, id: \.self) {filterResult in
                                Button(action: {
                                    selectedFilter = filterResult
                                }, label: {
                                    HStack {
                                        Text (filterResult)
                                        Spacer()
                                        if(selectedFilter == filterResult){
                                            Image(systemName: "checkmark")
                                            if (selectedFilter == "A-Z"){
                                                //                                               words =  wordList.words
                                                
                                            }
                                        }
                                    }
                                })
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 20, height: 18)
                                .padding(.leading, 10)
                                .foregroundColor(Color(.white))
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
            if (wordList.words.isEmpty && submenu == 0) {
                Spacer()
                VStack{
                    Image("Saly1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 300)
                    
                    Text("You don’t have any word yet, add by click ‘+’ icon in the top right corner.")
                        .font(.footnote)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.gray)
                Spacer()
            }else{
                ScrollView {
                    VStack{
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                            if(submenu == 0){
                                ForEach(wordList.filteredWordList, id: \.self) {word in
                                    NavigationLink(){
                                        WordDetailView(word: word)
                                        //                                            .navigationBarBackButtonHidden(true)
                                    }label:{
                                        WordCardView(word:word)
                                    }.padding(.vertical,3)
                                }
                            }
                            else{
                                
                                
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
                            
                        }}.navigationDestination(for: WordModel.self) { word in
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
                            WordAddEditView(tempWord: WordViewModel().environment(\.colorScheme, .light)
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
        
        //    function dynamicSort() {
        //        var sortOrder = 1;
        //        if(property[0] === "-") {
        //            sortOrder = -1;
        //            property = property.substr(1);
        //        }
        //        return function (a,b) {
        //            /* next line works with strings and numbers,
        //             * and you may want to customize it to your needs
        //             */
        //            var result = (a[property] < b[property]) ? -1 : (a[property] > b[property]) ? 1 : 0;
        //            return result * sortOrder;
        //        }
        //    }
    }
    
    struct WordLibraryView_Previews: PreviewProvider {
        static var previews: some View {
            WordLibraryView()
        }
    }
