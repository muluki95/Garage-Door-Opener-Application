//
//  NotificationList.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/5/25.
//

import SwiftUI


struct NotificationList:View{
    
    @ObservedObject var notificationsViewModel:NotificationsViewModel
    @State private var searchText = ""
    
    
    //filtered notifications based on search
    var filteredNotifications:[Notification]{
        if searchText.isEmpty{
            return notificationsViewModel.notifications
        } else {
            return notificationsViewModel.notifications.filter{
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.message.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    
    
    var body: some View {
        VStack{
            TextField("Search Notifications", text:$searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List(filteredNotifications, id: \.timestamp) { notification in
                NotificationRow(notification: notification)
            }
            
            .navigationTitle("Notifications")
            
            
            Button("Refresh Notifications"){
                Task{
                    await notificationsViewModel.fetchNotifications()
                }
            }
            
        }
        
    }
    
}
