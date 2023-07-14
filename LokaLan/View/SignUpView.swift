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
                Text("Buat Akun Anda").font(.title).bold()
                    .padding(.horizontal)
                    .padding(.top)
                
                    Text("Buat akun untuk melanjutkan")
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                Group{
                    Text("Nama ID").bold().padding(.top)
                    CustomTextField(text: $userName, placeholder: "Masukan nama ID")
                    
                    Text("Email").bold()
                    CustomTextField(text: $userEmail, placeholder: "Masukan Email")
                    
                    Text("Kata Sandi").bold()
                    CustomTextField(text: $userPassword, placeholder: "Masukan kata sandi")
                    
                    HStack{
                        Image(systemName: "checkmark.circle")
                        Text("Saya menerima Syarat dan Ketentuan layanan dan setuju dengan Kebijakan Privasi ini")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    } .padding(.top)
                    
                    Button{
            
                    } label: {
                        Text("Daftar")
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
                        Text("Sudah punya akun?")
                        Text("Masuk").foregroundColor(Color("Blue2"))
                        Text("untuk melanjutkan")
                        Spacer()
                    }
                    .font(.footnote)
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
