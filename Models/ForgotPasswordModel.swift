//
//  ForgotPasswordModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 4/2/25.
//

import Foundation

struct ForgotPasswordModel {
    var email: String = ""
    var isLoading: Bool = false
    var errorMessage: String? //the variable can hold a string or be nil
    var isSuccess: Bool = false
}
