//
//  UserResponse.swift
//  LokaLan
//
//  Created by Haning Galih Rani Kumbara on 13/07/23.
//

import Foundation
struct UserData: Codable, Hashable {
    var id: Int
    var username: String
    var email: String
}


struct UserResponse: Codable, Hashable{
    let message: String
    let user_rantau: UserData
}
