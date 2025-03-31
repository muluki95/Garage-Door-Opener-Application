//
//  RegisterViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/21/25.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
    
    
    func registerUser() {
        if username.isEmpty || password.isEmpty {
            print("Error: Please fill in all fields")
            return
        }
        print("User registered : \(username)")
    }
}


