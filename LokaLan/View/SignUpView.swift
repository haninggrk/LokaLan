//
//  SignUpView.swift
//  LokaLan
//
//  Created by michelle chandra on 07/07/23.
//

import SwiftUI

struct SignUpView: View {
    @State var userName = ""
    @State var userEmail = ""
    @State var userPassword = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                HStack{
                    Text("Sudah punya akun?")
                    NavigationLink{
                        LoginView()
                    }label: {
                        Text("Masuk")
                    }
                  
                }
                .padding(.bottom)
                .padding(.horizontal)
                Group{
                Text("Nama ID").bold()
                CustomTextField(text: $userName, placeholder: "Masukan nama ID")
                Text("Email").bold()
                CustomTextField(text: $userEmail, placeholder: "Masukan Email")
                Text("Kata Sandi").bold()
                CustomTextField(text: $userPassword, placeholder: "Masukan kata sandi")
                Button{
                    UserViewModel.shared.register(username:userName, password: userPassword, email: userEmail)
                    dismiss()
                } label: {
                    Text("Daftar")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(height: 30)
                }
                .position(x: 180, y: 70)
                    .fontWeight(.semibold)
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Blue2"))
                    
                }
                .padding(.horizontal)
                Spacer()
            }
            .navigationTitle("Daftar")
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("BgPurple"),.white, .white,.white, .white, .white, .white, Color("BgPurple")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
