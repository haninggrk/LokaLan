//
//  ProfileView.swift
//  LokaLan
//
//  Created by Andreas Lim on 30/06/23.
//

import SwiftUI

struct ProfileView: View {
    @State var userName = ""
    @State var userId = ""
    @State var userEmail = ""
    @State var userPassword = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ModalsBar()
            NavigationView {
                ScrollView {
                    VStack {
                        VStack(alignment:.leading){
                            Group{
                                VStack {
                                    HStack {
                                        Text("Nama").font(.subheadline).bold()
                                        Spacer()
                                    }
                                    CustomTextField(text: $userName, placeholder: "Masukan nama")
                                }.padding(.bottom, 15)
                                VStack {
                                    HStack {
                                        Text("Nama ID").font(.subheadline).bold()
                                        Spacer()
                                    }
                                    CustomTextField(text: $userId, placeholder: "Masukkan nama ID")
                                }.padding(.bottom, 15)
                                VStack {
                                    HStack {
                                        Text("Email").font(.subheadline).bold()
                                        Spacer()
                                    }
                                    CustomTextField(text: $userEmail, placeholder: "Masukan email")
                                }.padding(.bottom, 15)
                                VStack {
                                    HStack {
                                        Text("Password").font(.subheadline).bold()
                                        Spacer()
                                    }
                                    CustomTextField(text: $userPassword, placeholder: "Masukan password")
                                }.padding(.bottom, 15)
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        Spacer()
                        Button{
                            
                        }label: {
                            Text("Keluar").foregroundColor(Color(.red)).underline().padding(.bottom,40)
                        }
                    }
                    .padding()
                    .toolbar{
                        ToolbarItem(placement:.primaryAction ){
                            Button{
                                dismiss()
                            }label: {
                                Text("Simpan").foregroundColor(Color(.blue))
                            }
                        }
                        ToolbarItem(placement:.cancellationAction ){
                            Button{
                                dismiss()
                            }label: {
                                Text("Batal").foregroundColor(Color(.blue))
                            }
                        }
                    }
                    .navigationTitle("Profil")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
