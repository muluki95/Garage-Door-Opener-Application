//
//  SignInView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/16/25.
//
import SwiftUI
import Combine



struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    var body:some View {
        NavigationStack{
            //form fields
            VStack(spacing:20){
                InputView(text: $email, title: "Email", placeholder:"Enter your email address")
                    .autocapitalization(.none)
                InputView(text:$password, title:"Password", placeholder:"Enter your password", isSecureField: true)
                
                
                //signin button
                
                Button (action:{
                    
                })  {
                    HStack {
                        Text("Sign In")
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    
                }
                
                //create account button
                NavigationLink(
                    destination: CreateAccountView()
                        .navigationBarBackButtonHidden(true)
                ) {
                    HStack{
                        Text("Don't have an account?")
                        Text("Create one")
                            .fontWeight(.bold)
                    }
                    
                }
                
                
            }
            .padding(.horizontal, 20)
        }
    }
}
    

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
