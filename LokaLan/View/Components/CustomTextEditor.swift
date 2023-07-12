//
//  CustomTextEditor.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 27/06/23.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var text:String
    let placeholderString:String
    
    var body: some View {
        ZStack(alignment:.topLeading){
            if(text.isEmpty){
                HStack(alignment: .top){
                    Text("\(placeholderString)")
                        .padding(.all).foregroundColor(Color("TextGray"))
                    Spacer()
                }
            }
            TextEditor(text: $text).scrollContentBackground(.hidden).padding(10).background(Color(text.isEmpty ? "DarkGray":"LightGray")).cornerRadius(10).frame(width: .infinity,height: 100)
                .opacity(text.isEmpty ? 0.08 : 1)
        }
    }
}

//struct CustomTextEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextEditor()
//    }
//}
