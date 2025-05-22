//
//  SettingsScreenView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/18/25.
//
import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .padding(.leading, 5)
                .fontWeight(.bold)
            
            
        }
    }
}
struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(imageName:"gear", title:"Version", tintColor: Color.gray)
    }
}
