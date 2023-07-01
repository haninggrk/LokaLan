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
    @StateObject private var wordList = WordViewModel.shared
    @State private var isAddingWord = false
    @State var submenu: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    
                    VStack(alignment: .leading){
                        Text("Kosakata").font(.largeTitle.weight(.bold)).foregroundColor(.white).padding(.bottom,-1)
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Cari", text: $searchText)
                                .foregroundColor(Color.black)
                            Button(action: {
                                print("Add Rooms")
                            }) {
                                Image(systemName: "mic")
                            }
                        } .padding(.horizontal)
                            .frame(width: .infinity, height: 40)
                            .background(Color(.white))
                            .cornerRadius(5)
                            .foregroundColor(.black)
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
                                ForEach(wordList.words, id: \.self) {word in
                                    NavigationLink(){
                                        WordDetailView(word: word)
                                    }label:{
                                        WordCardView(word:word)
                                    }.padding(.vertical,3)
                                }
                                
                            }.navigationDestination(for: WordModel.self) { word in
                                WordDetailView(word: word)
                                
                            }.padding(.horizontal,32)
                        }
                    }
                }
            }
            
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
                        WordAddEditView()        .presentationDetents([.fraction(0.98)])

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
                        WordDetailView(word: WordViewModel.shared.words[0])                    }
                }
            }
            .background(Color("BgWhite"))
        }
        .navigationTitle("My Home")
    }
}

struct WordLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        WordLibraryView()
    }
}
