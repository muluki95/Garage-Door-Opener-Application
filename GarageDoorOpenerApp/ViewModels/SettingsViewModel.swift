//
//  SettingsViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/31/25.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var notificationEnabled: Bool = true
    
    
    //function to toggle dark mode
    
    func toggleDarkMode(){
        isDarkMode.toggle()
    }
    
    func enableNotifications(){
        notificationEnabled.toggle()
    }
}
