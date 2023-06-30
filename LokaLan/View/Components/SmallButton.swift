//
//  SmallButton.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 28/06/23.
//

import SwiftUI

struct SmallButton: View {
    var label:String
    var systemImage:String
    var color: Color
    var body: some View {
        Button{
            
        }label: {
            HStack{
                Text("\(label)")
                
                Image(systemName: "\(systemImage)")

            }.padding(.horizontal,8).padding(.vertical,5).background(.white)   .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color, lineWidth: 1)).foregroundColor(color)
        }

    }
}

struct SmallButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallButton(label: "Hello", systemImage: "globe",color: Color.blue)
    }
}
