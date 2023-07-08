//
//  WidgetView.swift
//  LokaLan
//
//  Created by Andreas Lim on 06/07/23.
//

import SwiftUI

struct WidgetView: View {
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    VStack {
                        HStack {
                            Button{
                                
                            }label: {
                                Image(systemName: "speaker.wave.2.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("BgBlue"))
                            }
                            
                            Spacer()
                            
                            Button{
                                
                            }label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("BgBlue"))
                            }
                        }
                        Spacer()
                    }
                    
                    VStack {
                        Text("Tetek Bengek")
                            .bold()
                            .font(.largeTitle)
                        .foregroundColor(Color("BgBlue"))
                        
                        Text("Semuanya dengan segala keribetan nya")
                            .foregroundColor(Color("BgBlue"))
                            .font(.title2)
                    }
                    .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .padding()
            .background(.white)
            .cornerRadius(20)
        }
        .padding(10)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("BgBlue"),Color("BgPurple")]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
