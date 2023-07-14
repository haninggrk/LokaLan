//
//  ResetPassView.swift
//  LokaLan
//
//  Created by michelle chandra on 14/07/23.
//

import SwiftUI

struct ResetPassView: View {
    @State var userPassword = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Atur Ulang Kata Sandi").font(.title).bold()
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("Masukkan kata sandi baru anda")
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                    .padding(.horizontal)
                
                Group{
                    Text("Kata Sandi Baru").bold().padding(.top)
                    CustomTextField(text: $userPassword, placeholder: "Masukan kata sandi baru")
                    
                    Text("Konfirmasi Kata Sandi").bold()
                    CustomTextField(text: $userPassword, placeholder: "Masukan konfirmasi kata sandi")
                    
                    Button{
                        
                    } label: {
                        Text("Kirim")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 30)
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .fontWeight(.semibold)
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Blue2"))

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

struct ResetPassView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassView()
    }
}
