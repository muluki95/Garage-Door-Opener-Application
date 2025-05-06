//
//  ForgotPasswordView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/20/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack {
            Text("Forgot Password")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.primary)
            
            TextField ("Enter your email", text: $viewModel.email)
                .padding()
                .background(Color.blue.opacity(0.2))
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .cornerRadius(10)
                
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .padding()
                    .multilineTextAlignment(.center)
            }
            
            if viewModel.isSuccess {
                Text("Check your email for reset instructions")
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                    .padding()
                    .multilineTextAlignment(.center)
            }
            Button( action:{
                viewModel.resetPassword()
            }){
                if viewModel.isLoading{
                    ProgressView()  //loading spinner
                } else {
                    Text("Reset Password")
                        .frame(width: 200 , height:20)
                        .padding()
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                        .background(Color.blue.opacity(0.5))
                    
                }
            }
        }
        
    }
}
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View{
        ForgotPasswordView()
    }
}
