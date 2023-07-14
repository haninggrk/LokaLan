//
//  InsertOTP.swift
//  LokaLan
//
//  Created by michelle chandra on 14/07/23.
//

import SwiftUI

struct InsertOTP: View {
    @Environment(\.dismiss) private var dismiss
    @State var pinOne = ""
    @State var pinTwo = ""
    @State var pinThree = ""
    @State var pinFour = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Masukkan Kode OTP").font(.title).bold()
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 4)
                
                Text("Kami mengirimkan kode verifikasi untuk merubah password anda")
                    .foregroundColor(.gray)
                    .padding(.bottom)
                    .padding(.horizontal)
                Group{
                    Text("Email telah dikirim ke :")
                        .foregroundColor(.gray)
                    Text("jesslyn.sudarsono@gmail.com")
                        .foregroundColor(.gray)
                    
                    HStack {
                        Spacer()
                        RoundedRectangleTextField2(text: $pinOne)
                        RoundedRectangleTextField2(text: $pinTwo)
                        RoundedRectangleTextField2(text: $pinThree)
                        RoundedRectangleTextField2(text: $pinFour)
                        Spacer()
                    }
                    .padding(.top, 36)
                    .padding(.bottom, 36)
                    
                    HStack{
                        Spacer()
                        Text("Saya tidak menerima kode")
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding(.top)
                    HStack{
                        Spacer()
                        Text("Kirim ulang")
                            .foregroundColor(Color("Blue")).bold()
                        Spacer()
                    }
                    
                    Button{
                        
                    } label: {
                        Text("Verifikasi")
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

struct RoundedRectangleTextField2: View {
    @Binding var text: String
    
    var body: some View {
        let hasInput = !text.isEmpty
        RoundedRectangle(cornerRadius: 10)
            .stroke(hasInput ? Color("Blue") : Color.gray.opacity(0.5), lineWidth: 1) // Add border
            .background(Color.clear)
            .frame(width: 70, height: 70)
            .overlay(
                TextField("", text: $text)
                    .foregroundColor(hasInput ? Color("Blue") : .black)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .onChange(of: text) { newValue in
                        if newValue.count > 1 {
                            text = String(newValue.prefix(1))
                        }
                    }
            )
    }
}

struct InsertOTP_Previews: PreviewProvider {
    static var previews: some View {
        InsertOTP()
    }
}
