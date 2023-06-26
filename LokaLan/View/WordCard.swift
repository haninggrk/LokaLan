//
//  WordCard.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 23/06/23.
//

import SwiftUI

struct WordCard: View {
    var body: some View {
        ZStack{
            Color.blue
     
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text("Kon").foregroundColor(.blue).bold()
                        Text("Pinned")
                        Image(systemName: "pin").rotationEffect(Angle(degrees: 20))
                    }
                    Text("\"Kamu\"")
                }
                Spacer()
                
            }
            .padding(10).padding(.bottom,20).background(.white).cornerRadius(10).padding(30)

        }
  
    }
}

struct WordCard_Previews: PreviewProvider {
    static var previews: some View {
        WordCard()
    }
}
