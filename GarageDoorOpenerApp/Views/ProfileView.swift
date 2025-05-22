//
//  ProfileView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser{
        List{
            Section{
                HStack{
                    Text(user.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color.gray)
                        .clipShape(Circle())
                    VStack(alignment:.leading, spacing: 4){
                        Text(user.name)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Text(user.email)
                            .font(.footnote)
                            .accentColor(.gray)
                    }
                    
                }
            }
            Section("General"){
                HStack{
                    SettingsRowView(imageName:"gear", title:"Version",tintColor: .gray)
                    Spacer()
                    Text("1.0.0")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                }
            }
                Section("Account"){
                    Button(action:{
                        viewModel.signOut()
                        
                    }){
                        SettingsRowView(imageName:"arrow.left.circle.fill", title:"Sign Out", tintColor: Color.red)
                        
                    }
                    }
                }
            
        } 
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
