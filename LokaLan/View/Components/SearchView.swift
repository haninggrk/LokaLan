//
//  SearchView.swift
//  LokaLan
//
//  Created by Andreas Lim on 02/07/23.
//

import SwiftUI

struct SearchView: View {
    @State private var isOpenSpeech = false
    @Binding  var searchText:String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Cari", text: $searchText)
                .foregroundColor(Color("Blue"))
            Button(action: {
                isOpenSpeech = true
            }) {
                Image(systemName: "mic")
            }
            .sheet(isPresented: $isOpenSpeech){
                SpeechToTextView(searchText: $searchText)
                    .presentationDetents([.fraction(0.28)])
                    .presentationDragIndicator(.visible)
            }
        } .padding(.horizontal)
            .frame(width: .infinity, height: 40)
            .background(Color(.white))
            .cornerRadius(10)
            .foregroundColor(Color("Blue"))
    }
}
//
//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
////        SearchView()
//    }
//}
