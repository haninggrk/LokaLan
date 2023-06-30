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
        NavigationView{
            
            VStack {
                Image(systemName:"person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .cornerRadius(100)
                    .clipped()
                    .padding(.top, 40)
                VStack(alignment:.leading){
                    Group{
                        Text("Nama").bold()
                        CustomTextField(text: $userName, placeholder: "masukan nama")
                        Text("Nama ID").bold()
                        CustomTextField(text: $userId, placeholder: "masukkan nama ID")
                        Text("Email").bold()
                        CustomTextField(text: $userEmail, placeholder: "masukan email")
                        Text("Password").bold()
                        CustomTextField(text: $userPassword, placeholder: "masukan password")
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }.padding(20)
                .toolbar{
                    
                    ToolbarItem(placement:.primaryAction ){
                        Text("Simpan").bold().foregroundColor(Color(.blue))
                        
                    }
                    ToolbarItem(placement: .principal) {
                        ZStack {
                            Text("Profile")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.primary)
                        }
                    }
                    ToolbarItem(placement:.cancellationAction ){
                        Text("Batal").bold().foregroundColor(Color(.blue))
                    }
                    
                    
                }.navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
