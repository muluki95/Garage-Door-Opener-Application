//
//  SettingsScreenView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/18/25.
//
import SwiftUI

struct SettingsScreenView: View {
    @EnvironmentObject var viewModel:SettingsViewModel
    
    var body: some View {
        Form {
            Toggle("Dark Mode",isOn: $viewModel.isDarkMode )
            Toggle("Enable notifications", isOn:$viewModel.notificationEnabled)
        }
        .padding(20)
        .navigationTitle(Text("Settings"))
    }
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreenView()
            .environmentObject(SettingsViewModel())
    }
}
