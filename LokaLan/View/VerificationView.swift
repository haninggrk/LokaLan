//
//  VerificationView.swift
//  LokaLan
//
//  Created by michelle chandra on 13/07/23.
//

import SwiftUI

struct VerificationView: View {
    @Environment(\.dismiss) private var dismiss
    @State var pinOne = ""
    @State var pinTwo = ""
    @State var pinThree = ""
    @State var pinFour = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Verifikasi Email Anda").font(.title).bold()
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("Kami mengirimkan kode untuk verifikasi akun anda")
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
                        RoundedRectangleTextField(text: $pinOne)
                        RoundedRectangleTextField(text: $pinTwo)
                        RoundedRectangleTextField(text: $pinThree)
                        RoundedRectangleTextField(text: $pinFour)
                        Spacer()
                    }
                    .padding(.top, 36)
                    .padding(.bottom, 36)
                    
                    HStack{
                        Spacer()
                        Text("Saya tidak menerima kode")
                            .foregroundColor(.gray)
                        Spacer()
                    }
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

struct RoundedRectangleTextField: View {
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

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}
