//
//  SwiftUIView.swift
//  LokaLan
//
//  Created by michelle chandra on 07/07/23.
//

import SwiftUI

struct LoginView: View {
    @State var userName = ""
    @State var userPassword = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                HStack{
                    Text("Belum punya akun?")
                    Text("Daftar") //nanti dibuat nge link ke SignUpView
                }
                .padding(.bottom)
                .padding(.horizontal)
                Group{
                Text("Email atau Nama ID").bold()
                CustomTextField(text: $userName, placeholder: "Masukan email atau nama ID")
                Text("Kata Sandi").bold()
                CustomTextField(text: $userPassword, placeholder: "Masukan kata sandi")
                Button{
                        
                } label: {
                    Text("Masuk")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(height: 30)
                }
                .position(x: 180, y: 150)
                    .fontWeight(.semibold)
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Blue2"))
                    .frame(alignment: .center)
                }
                .padding(.horizontal)
                Spacer()
            }
            .navigationTitle("Selamat datang")
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("BgPurple"),.white, .white,.white, .white, .white, .white, Color("BgPurple")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
