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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Selamat Datang").font(.largeTitle).bold()
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("Masuk untuk melanjutkan")
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                    .padding(.horizontal)
                
                Group{
                    Text("Email atau Nama ID").bold().padding(.top)
                    CustomTextField(text: $userName, placeholder: "Masukan email atau nama ID")
                    
                    Text("Kata Sandi").bold()
                    CustomTextField(text: $userPassword, placeholder: "Masukan kata sandi")
                    HStack{
                        Spacer()
                        Text("Lupa kata sandi?")
                            .font(.system(size: 14))
                            .foregroundColor(Color("Blue2"))
                    }
                    
                    Button{
                        
                    } label: {
                        Text("Masuk")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 30)
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .fontWeight(.semibold)
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Blue2"))
                    
                    HStack(spacing: 4){
                        Spacer()
                        Text("Belum punya akun?")
                        Text("Daftar").foregroundColor(Color("Blue2"))
                        Text("untuk melanjutkan")
                        Spacer()
                    }
                    .font(.system(size: 14))
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.horizontal)
            .toolbar{
                ToolbarItem(placement:.cancellationAction ){
                    Button{
                        dismiss()
                    }label: {
                        Text("Batal").bold().foregroundColor(Color(.blue))
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
