//
//  AuthView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//

import SwiftUI
import Combine


struct CreateAccountView: View{
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var confirmPassword = ""
    @EnvironmentObject var viewModel:AuthViewModel
    
    var body: some View {
        NavigationStack{
            //form fields
            VStack(spacing:20){
                InputView(text: $email, title: "Email", placeholder:"amelia@example.com")
                InputView(text: $name, title:"Name", placeholder:"Enter your fullname")
                InputView(text:$password, title:"Password", placeholder:"Enter your password", isSecureField: true)
                ZStack(alignment: .trailing){
                    InputView(text: $confirmPassword, title:"Confirm Password", placeholder:"Confirm your password", isSecureField:true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(Color.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(Color.red)
                        }
                    }
                }
                
                //create account button
                
                Button (action:{
                    Task{
                        do {
                    try await viewModel.createUser(email: email, password: password, name: name)
                                } catch {
                                    
                        print("Failed to create user:", error.localizedDescription)
                                    
                                }
                    }
                })  {
                    HStack {
                        Text("Create Account")
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .disabled(formIsValid)
                    .opacity(formIsValid ? 1 : 0.5)
                    
                }
                //back to sign in page
                NavigationLink(
                    destination: SignInView()
                        .navigationBarBackButtonHidden(true)
                ) {
                    HStack{
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.bold)
                    }
                    
        
                    
                }
                
            }
            .padding(.horizontal, 20)
        }
        
    }
    }
// authentication form protocol
extension CreateAccountView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty &&
        email.contains("@") &&
        !password.isEmpty &&
        password.count > 5 &&
        password.count < 100 &&
        name.count > 0 &&
        confirmPassword == password
    }
    
    
}



struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            .environmentObject(AuthViewModel())
    }
}

 

