//
//  ForgotPasswordViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 4/2/25.
//
import SwiftUI

class ForgotPasswordViewModel: ObservableObject {
     @Published var email: String = ""
        @Published var isLoading: Bool = false
        @Published var isSuccess: Bool = false
        @Published var errorMessage: String?
    
    //function to reset password
    
    func resetPassword(){
        guard !email.isEmpty else {
            errorMessage = "Email is required."
            return
        }
    }
}
