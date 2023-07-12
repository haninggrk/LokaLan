//
//  CustomTextField.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 27/06/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            TextField("\(placeholder)", text: $text)
                .padding(10)
                .background(Color("LightGray"))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("LightGray"), lineWidth: 2)
                )
        }
    }
}

//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField()
//    }
//}
