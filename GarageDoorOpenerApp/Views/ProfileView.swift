//
//  ProfileView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    var body: some View {
        Button("Sign Out", action:{
            try! Auth.auth().signOut()
        })
    }
}
