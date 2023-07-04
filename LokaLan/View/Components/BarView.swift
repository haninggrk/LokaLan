//
//  BarView.swift
//  LokaLan
//
//  Created by Andreas Lim on 30/06/23.
//

import SwiftUI

struct BarView: View {
    var value: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
                .frame(width: (UIScreen.main.bounds.width - CGFloat(20) * 11) / CGFloat(30), height: value)
        }
    }
}
