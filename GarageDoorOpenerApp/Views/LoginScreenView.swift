//
//  ContentView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/18/25.
//

import SwiftUI

struct LoginScreenView: View {
    //state variables for user input
    @StateObject private var viewModel = LoginScreenViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                
                Text("GARAGE DOOR OPENER APPLICATION")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .padding(.top,40)
                
                Spacer()
                
                //username field
                TextField("Enter your username", text:$viewModel.username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .frame(width:350, height: 20)
                    .padding(.bottom, 50)
                    .autocapitalization(.none)
                
                SecureField("Enter your password", text:$viewModel.password)
                    .padding(.top, 30)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .frame(width:350, height: 20)
                    
                
                //Login button
                
                Button(action:viewModel.loginUser){
                    
                    Text("Login")
                        .frame(maxWidth: .infinity) // Makes button stretch
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.top, 40)
                
                Spacer()
                
                
                //Create an account button
                Button(action:{
                    print("register pressed")
                    
                }){
                    Text("Create an account")
                        .frame(width:350, height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                    
                    
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                //Forgot password button
                Button(action:{
                    print("forgot password pressed")
                    
                }){
                    Text("Forgot password")
                        .frame(width:350, height:50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                        .padding(.bottom, 40)
                }
                
                Spacer()
                
            }
            .padding()
        }
        
    }
}



    struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
