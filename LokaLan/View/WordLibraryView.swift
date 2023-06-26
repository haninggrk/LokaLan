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
    @State private var submenu = 0

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Kosakata")
                        .foregroundColor(.white)
                        .font(.title.bold())
                        .accessibilityAddTraits(.isHeader)
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Cari", text: $searchText)
                            .foregroundColor(Color.black)
                        Button(action: {
                            print("Add Rooms")
                        }) {
                            Image(systemName: "mic")
                        }
                    }
                    .padding()
                    .frame(width: .infinity, height: 35)
                    .background(Color(.white))
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .padding(.horizontal, 45)
                    .padding(.bottom, 20)
                    HStack{
                        HStack {
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Text("Lokal")
                                    .bold()
                            }
                            .foregroundColor(.black)
                            Spacer()
                            
                        }
                        .padding(.vertical,20)
                        .background(RoundedCorners(color: Color("BgWhite"),bgcolor: .white.opacity(0), tl: 0, tr: 30, bl: 0, br: 0))
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Text("Global")
                                    .bold()
                            }
                            .foregroundColor(Color(.white))
                            Spacer()
                        }
                        .padding(.vertical,20)
                        .background(RoundedCorners(color: Color("BgPurple2"),bgcolor: Color("BgWhite"), tl: 0, tr: 0, bl: 30, br: 0))
                    }.edgesIgnoringSafeArea(.all)
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
                                        WordCardView(word: word)
                                    }
                                }

                            }.navigationDestination(for: WordModel.self) { word in
                                WordDetailView(word: word)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isEditWord = true
                    }) {
                        Label("Edit", systemImage: "pencil")
                    }
                    .foregroundColor(Color(.white))
                    .sheet(isPresented: $isEditWord){
                        WordDetailView(word: WordViewModel.shared.words[0])
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        isAddWord = true
                    }) {
                        Label("AddWord", systemImage: "plus")
                    }
                    .foregroundColor(Color(.white))
                    .sheet(isPresented: $isAddWord){
                        LibraryAddEditView()
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
