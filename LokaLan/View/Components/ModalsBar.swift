//
//  ModalsBar.swift
//  LokaLan
//
//  Created by Andreas Lim on 12/07/23.
//

import SwiftUI

struct ModalsBar: View {
    var body: some View {
        Capsule()
            .fill(Color(uiColor: .darkGray))
            .frame(width: 70, height: 3)
            .padding(.vertical,10)
    }
}

struct ModalsBar_Previews: PreviewProvider {
    static var previews: some View {
        ModalsBar()
    }
}
