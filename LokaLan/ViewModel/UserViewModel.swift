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
    @AppStorage("email") var email: String = ""
    @AppStorage("id") var id: Int = 0
    static var shared:UserViewModel = UserViewModel()
    func login(){
        
    }
    
    
    func register(username: String, password: String, email: String) {
//        let url = URL(string: "http://127.0.0.1:8000/register")! // Replace with your actual API endpoint
        let url = URL(string: "https://lokalan.curiousgalih.biz.id/register")! // Replace with your actual API endpoint

        // Create the request body data
        let parameters: [String: Any] = [
            "username": username,
            "password": password,
            "email": email
        ]
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set the request body data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error creating request body: \(error)")
            return
        }
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error making API request: \(error)")
                return
            }
            
            guard let data = data else {
                print("Empty response data")
                return
            }
            
            // Process the response data
            do {
                let apiResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                self.username = apiResponse.user_rantau.username
                self.email = apiResponse.user_rantau.email
                self.id = apiResponse.user_rantau.id

            } catch {
                print(String(data: data, encoding: String.Encoding.utf8 ))
                print("Error parsing response data: \(error)")
            }
        }
        
        task.resume()
    }
 





    func logout(){
        username = ""
        id = 0
    }
    
}
