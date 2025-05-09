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
    @State private var  hasStartedLoading = false
    
    //filtered notifications based on search
    var filteredNotifications:[Notification]{
        //safely unwarap the loaded notifications from Loadable<[Notification>] enum
        guard case let .loaded(notifications) = notificationsViewModel.notifications else{
            return []
            
        }
        //if searchText is empty return all loaded notifications
        if searchText.isEmpty {
            return notifications}
        else {
            // Filter notifications by title or message containing the search text
            return notifications.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.message.lowercased().contains(searchText.lowercased())
            }
        }
        
    }
    
    
    var body: some View {
        VStack{
            //TextField("Search Notifications", text:$searchText)
            //.textFieldStyle(RoundedBorderTextFieldStyle())
            //.padding()
            //Handles the various loading states
            
            switch notificationsViewModel.notifications {
            case.loading:
                ProgressView("Loading Notifications...")
                    .onAppear {
                        if !hasStartedLoading {
                            hasStartedLoading = true
                            
                            Task {
                                try await Task.sleep(nanoseconds:1_500_000_000) //there is a delay of 1.5seconds before it fetches the notifications
                                await notificationsViewModel.fetchNotifications()
                            }
                        }
                    }
            case.error(let error):
                VStack{
                    Text("Failed to load Notifications:")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                    Button("Retry"){
                        Task{
                            await notificationsViewModel.fetchNotifications()
                        }
                    }
                }
                .padding()
                
            case .loaded(let notifications) where notifications.isEmpty :
                VStack{
                    Text("No notifications found")
                        .foregroundColor(.gray)
                    Button("Refresh Notifications"){
                        Task{
                            await notificationsViewModel.fetchNotifications()
                        }
                        
                    }
                }
            case .loaded:
                List(filteredNotifications, id: \.timestamp) { notification in
                    NotificationRow(notification: notification)
                }
                
            }
            
        }
        
        .navigationTitle("Notifications")
        
    }
}
    
    

