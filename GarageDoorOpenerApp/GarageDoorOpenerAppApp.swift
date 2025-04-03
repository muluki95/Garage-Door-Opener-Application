//
//  GarageDoorOpenerAppApp.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/18/25.
//

import SwiftUI

@main
struct GarageDoorOpenerAppApp: App {
    @StateObject private var notificationsViewModel = NotificationsViewModel()
    @StateObject private var garageViewModel: GarageDoorViewModel
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    init() {
            // Ensure the same NotificationsViewModel instance is passed to GarageDoorViewModel
            let sharedNotificationsViewModel = NotificationsViewModel()
            _garageViewModel = StateObject(wrappedValue: GarageDoorViewModel(notificationsViewModel: sharedNotificationsViewModel))
            _notificationsViewModel = StateObject(wrappedValue: sharedNotificationsViewModel)
        }
    
    var body: some Scene {
        WindowGroup {
            GarageHomeView(
            notificationsViewModel: notificationsViewModel,
            garageViewModel: garageViewModel
            )
            .environmentObject(settingsViewModel)
            .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light) // Applies dark mode globally
        }
    }
}
