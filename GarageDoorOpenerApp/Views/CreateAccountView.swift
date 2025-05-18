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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            //form fields
            VStack(spacing:20){
                InputView(text: $email, title: "Email", placeholder:"Enter your email address")
                    .autocapitalization(.none)
                InputView(text: $name, title:"Name", placeholder:"Enter your fullname")
                InputView(text:$password, title:"Password", placeholder:"Enter your password", isSecureField: true)
                InputView(text: $confirmPassword, title:"Confirm Password", placeholder:"Confirm your password", isSecureField:true)
                
                
                //signin button
                
                Button (action:{
                    
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
                    
                }
                
                Button (action:{
                    dismiss()
                })  {
                    HStack {
                        Text("Already have an account? Sign In")
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.left")
                    }
                    
        
                    
                }
                
            }
            .padding(.horizontal, 20)
        }
        
    }
    }





struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

 

