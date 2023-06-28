//
//  CustomTextEditor.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 27/06/23.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var text:String
    var body: some View {
        TextEditor(text: $text).scrollContentBackground(.hidden).padding(10).background(Color("LightGray")).cornerRadius(10).frame(width: .infinity,height: 100)
    }
}

//struct CustomTextEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextEditor()
//    }
//}
