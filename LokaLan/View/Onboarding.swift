//
//  Onboarding.swift
//  LokaLan
//
//  Created by michelle chandra on 07/07/23.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Group{
                    Spacer()
                    Image("Logo")
                        .padding(.bottom, 48)
                    Button{
                        
                    } label: {
                        Text("Masuk")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 30)
                    }
                    .fontWeight(.semibold)
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Blue2"))
                    .padding(.horizontal)
                    
                    Button{
                        
                    } label: {
                        Text("Daftar akun baru")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color("Blue2"))
                            .frame(height: 40)
                    }
                    .fontWeight(.semibold)
                    .buttonStyle(.plain)
                    .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("Blue2")))
                    .padding(.horizontal)
                    Spacer()
                }
                .frame(alignment: .center)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("BgPurple"),.white, .white,.white, .white, .white, .white, Color("BgPurple")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
