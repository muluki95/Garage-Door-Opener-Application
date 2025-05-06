//
//  NotificationList.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/5/25.
//

import SwiftUI


struct NotificationList:View{
    let notifications: [Notification]
    @State private var searchText = ""
    
    
    //filtered notifications based on search
    var filteredNotifications:[Notification]{
        if searchText.isEmpty{
            return notifications
        } else {
            return notifications.filter{
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.message.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Search Notifications", text:$searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

                List(notifications, id: \.timestamp) { notification in
                    NotificationRow(notification: notification)
                }
                .searchable(text:$searchText)
                .navigationTitle("Notifications")
                //.id(UUID()) // Forces SwiftUI to refresh when notifications update
                
                Spacer()
            }
            
            //.toolbar {
                //Button ("Clear All"){
                //notificationsViewModel.clearAllNotifications()
                //}
            //}
        }
    }

        

