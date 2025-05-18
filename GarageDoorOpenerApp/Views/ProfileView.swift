//
//  ProfileView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    var body: some View {
        List{
            Section{
                HStack{
                    Text("EN")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color.gray)
                        .clipShape(Circle())
                    VStack(alignment:.leading, spacing: 4){
                        Text("Esther Nzomo")
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Text("esther@gmail.com")
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
                    
                }
            
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
