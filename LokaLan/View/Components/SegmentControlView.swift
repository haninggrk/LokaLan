//
//  SegmentedControlView.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 28/06/23.
//

import SwiftUI

struct SegmentControlView: View {
    @Binding var submenu: Int
    
    var body: some View {
        HStack{
            HStack {
                Spacer()
                Text("Lokal")
                    .foregroundColor(submenu == 0 ? .blue:.white).bold()
                Spacer()
                
            }
            .padding(.vertical,20)
            .background(RoundedCorners(color:Color( submenu == 0 ? "BgWhite":"BgPurple2"),bgcolor: submenu == 0 ? .white.opacity(0) : Color(submenu == 0 ? "BgPurple2" : "BgWhite"), tl: 0, tr: submenu == 0 ? 30 : 0, bl: 0, br: submenu == 0 ? 0 : 30))
            .onTapGesture{
                submenu = 0
            }
            
            HStack {
                Spacer()
                
                Text("Global")
                    .bold()
                
                    .foregroundColor(submenu == 0 ? .white:.blue)
                Spacer()
            }
            .padding(.vertical,20)
            .background(RoundedCorners(color: Color(submenu == 0 ?  "BgPurple2":"BgWhite"),bgcolor: Color(submenu == 0 ? "BgWhite":"BgPurple2"), tl: submenu == 1 ? 30:0, tr: 0, bl: submenu == 0 ? 30:0, br: 0))
            .onTapGesture{
                submenu = 1
            }
            
            
            
        }.ignoresSafeArea(.all)
    }
}

