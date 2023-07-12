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
    var is_activated: Bool
    let action: () -> Void
    
    
    var body: some View {
        Button{
            action()
        }label: {
            HStack{
                Text("\(label)")
                
                Image(systemName: "\(systemImage)")

            }.padding(.horizontal,8).padding(.vertical,5).background(is_activated ? Color("SmallButtonLightBlue"):.white)   .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color, lineWidth: 1)).foregroundColor(color)
        }

    }
}

struct SmallButton_Previews: PreviewProvider {
    @State static var is_activated = true

    static var previews: some View {
        SmallButton(label: "Hello", systemImage: "globe",color: Color.blue,is_activated: is_activated){
            
        }
    }
}
