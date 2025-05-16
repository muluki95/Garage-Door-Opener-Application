//
//  AuthView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//

import SwiftUI
import Combine


struct CreateAccountForm: View{
    @StateObject var viewModel:AuthViewModel.CreateAccountViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        Form{
            TextField("Name",text:$viewModel.name)
                .textContentType(.name)
                .textInputAutocapitalization(.words)
            TextField("Email",text:$viewModel.email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
            SecureField("Password",text:$viewModel.password)
                .textContentType(.newPassword)
            Button("Create Account", action:viewModel.submit)
            Button("Sign In",action:dismiss.callAsFunction)
        }
            .navigationTitle("Create an Account")
            .alert("Cannot Create Account", isPresented:Binding<Bool>(
                get:{viewModel.error != nil},
                set:{newValue in
                    if !newValue {viewModel.error = nil}
                })
            ) {
                Button("OK", role: .cancel){
                    viewModel.error = nil
                }
                
            } message: {
                Text(viewModel.error?.localizedDescription ?? "Unknown Error")
            }
            .disabled(viewModel.isWorking)
            }
    }


struct SignInForm<Footer:View > : View {
    @StateObject  var viewModel:AuthViewModel.SignInViewModel
    @ViewBuilder let footer:() -> Footer
    
    var body: some View {
        VStack {
            TextField("Email", text:$viewModel.email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
            SecureField("Password", text:$viewModel.password)
            footer()
        }
        .navigationBarHidden(true)
        .onSubmit(viewModel.submit)
        .disabled(viewModel.isWorking)
    }
    
}
    
    


 

