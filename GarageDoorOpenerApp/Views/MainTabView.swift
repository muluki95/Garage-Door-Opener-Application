//
//  MainTabView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//
import SwiftUI

struct MainTabView: View {
    @ObservedObject var notificationsViewModel: NotificationsViewModel
    @ObservedObject var garageViewModel:GarageDoorViewModel
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        TabView{
            NavigationStack{
                GarageHomeView(
                    notificationsViewModel: notificationsViewModel,
                    garageViewModel: garageViewModel
                )
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            NavigationStack{
                NotificationList(notificationsViewModel:notificationsViewModel)
            }
            .tabItem {
                Image(systemName: "bell.fill")
                Text("Notifications")
            }
            NavigationStack {
                SettingsScreenView()
                    .environmentObject(settingsViewModel)
            }
            .tabItem{
                Image(systemName: "gear")
                Text("Settings")
            }
            NavigationStack{
                ProfileView() 
            }
                    .tabItem {
                        Image(systemName:"person")
                        Text("Profile")
                        
                    }
            
        }
        
        
    }
    
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        let repo = NotificationRepository()
        let notificationsVM = NotificationsViewModel(repository: repo)
        let garageVM = GarageDoorViewModel(notificationsViewModel: notificationsVM)
        MainTabView(notificationsViewModel: notificationsVM, garageViewModel: garageVM)
    }
}

