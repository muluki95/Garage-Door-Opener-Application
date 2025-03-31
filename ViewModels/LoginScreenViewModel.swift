//
//  LoginScreenViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/21/25.
//

import SwiftUI

class LoginScreenViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    // function to ensure the username and password are filled
    
    func loginUser(){
        if username.isEmpty || password.isEmpty{
            print(" Please fill in both username and password")
        } else{
            print("Username: \(username), Password: \(password)")
        }
        
        
        if validateLogin(username: username, password:password){
            isAuthenticated = true
        }else{
            print("Invalid username or password")
            
        }
    }
    func validateLogin(username: String, password: String) -> Bool {
        return username == "admin" && password == "password123" // Replace with real authentication logic
    }
}
