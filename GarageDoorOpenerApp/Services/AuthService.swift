//
//  AuthService.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/13/25.
//
import FirebaseAuth

@MainActor
class AuthService: ObservableObject {
    @Published var isAuthenticated = false
    
    private let auth = Auth.auth()  //initializes firebase auth object and stores it in a constant auth
    private var listener:AuthStateDidChangeListenerHandle?  // listener-keeps a strong reference to the state changelistener so it doesn't get deallocated
    
    init(){
        listener = auth.addStateDidChangeListener { [weak self] _, user in
            self? .isAuthenticated = (user != nil)
        }
    }
}
