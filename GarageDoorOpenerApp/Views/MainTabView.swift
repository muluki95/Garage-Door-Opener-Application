//
//  MainTabView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel
    @EnvironmentObject var garageViewModel:GarageDoorViewModel
    @EnvironmentObject var viewModel: AuthViewModel

    
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
        let authVM = AuthViewModel()
        
        MainTabView()
            .environmentObject(authVM)
            .environmentObject(notificationsVM)
            .environmentObject(garageVM)
    }
}
