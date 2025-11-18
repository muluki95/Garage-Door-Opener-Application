//
//  AuthViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
        var formIsValid: Bool { get }
    }

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    
    init(){
        self.userSession = Auth.auth().currentUser
        addAuthStateListener()
        Task{
            await getCurrentUser()
        }
    }
    
    private func addAuthStateListener() {
       authStateListenerHandle =  Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.userSession = user
        }
    }
    func signIn(email:String, password:String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password:password)
            self.userSession = result.user
            await getCurrentUser()
        } catch {
            print("Failed to sign in:\(error.localizedDescription)")
            
        }
        
    }
    
    func createUser(email:String, password: String, name: String) async throws {
            let result = try await Auth.auth().createUser(withEmail:email, password:password)
            self.userSession = result.user
            let user = User(uid: result.user.uid, name:name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await getCurrentUser()
            
            print("User created successfully")
        
    }
    
    func signOut() {
        do{
            try  Auth.auth().signOut()
            DispatchQueue.main.async {
                self.userSession =  nil   //wipes out user session and takes us back to sign in screen
                self.currentUser = nil   //wipes out current user data
                    }
           
            
        } catch {
            print("Failed to sign out user: \(error.localizedDescription)")
            
        }
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else { return }
        
        try await user.delete()
        
    }
    
    func getCurrentUser() async  {
        guard let uid = self.userSession?.uid else {
            print(" No user session found.")
            return
        }
        do{
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as:User.self)
            print(" Current user loaded: \(self.currentUser?.name ?? "Unknown")")
        } catch {
            print(" Failed to fetch user: \(error.localizedDescription)")
        }
    }
    
}
