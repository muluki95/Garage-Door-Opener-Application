//
//  SettingsViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/31/25.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var userSettings = UserSettings(isDarkMode: false , notificationEnabled: true )
    
    
    //function to toggle dark mode
    
    func toggleDarkMode(){
        userSettings.isDarkMode.toggle()
    }
    
    func enableNotifications(){
        userSettings.notificationEnabled.toggle()
    }
}
