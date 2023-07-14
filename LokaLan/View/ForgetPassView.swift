//
//  ForgetPassView.swift
//  LokaLan
//
//  Created by michelle chandra on 14/07/23.
//

import SwiftUI

struct ForgetPassView: View {
    @State var userEmail = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Lupa Kata Sandi?").font(.title).bold()
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("Jangan khawatir, masukkan email anda")
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .padding(.horizontal)
                
                Group{
                    Text("Email").bold()
                    CustomTextField(text: $userEmail, placeholder: "Masukan Email")
                        .padding(.bottom)
                    Button{
                        
                    } label: {
                        Text("Lanjutkan")
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

struct ForgetPassView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPassView()
    }
}
