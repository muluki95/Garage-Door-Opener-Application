//
//  UserModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/16/25.
//
import Foundation
import Combine
import SwiftUI


struct User: Identifiable,Equatable, Codable {
    var id: String {uid}
    var uid: String
    var name: String
    var email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
    
}
extension User {
    static var testUser = User(uid:"1", name:"Esther", email:"esther@gmail.com" )
}
