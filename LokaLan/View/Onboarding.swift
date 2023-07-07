//
//  Onboarding.swift
//  LokaLan
//
//  Created by michelle chandra on 07/07/23.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        Button{
                
        } label: {
            Text("Log In")
                .frame(maxWidth: .infinity, alignment: .center)
        }
            .fontWeight(.semibold)
            .buttonStyle(.borderedProminent)
            .tint(Color("Blue2"))
            .padding(.horizontal)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
