//
//  RegisterView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/20/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack(spacing:70) {
            Text("CREATE AN ACCOUNT")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding(.bottom,40)
            TextField("Enter your username", text:$viewModel.username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(width:350, height: 20)
                .autocapitalization(.none)
            
            
            SecureField("Enter your password", text:$viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(width:350, height: 20)
            
            SecureField("Confirm password", text:$viewModel.confirmPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(width:350, height: 20)
            
            TextField("Enter your email", text:$viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(width:350, height: 20)
               // .padding(.bottom, 50)
                .autocapitalization(.none)
            
            
            Button(action:viewModel.registerUser){
                
                Text("Register")
                    .frame(width: 200) 
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            
        
            
            
        }
        .padding(.top,60)
    }
}

struct RegisterView_Previews: PreviewProvider {
static var previews: some View {
    RegisterView()
}
}
