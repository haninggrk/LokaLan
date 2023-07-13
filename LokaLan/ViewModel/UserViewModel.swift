//
//  UserViewModel.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 21/06/23.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject{
    @AppStorage("username") var username: String = ""
    @AppStorage("id") var id: Int = 0
    
    func login(){
        
    }
}
