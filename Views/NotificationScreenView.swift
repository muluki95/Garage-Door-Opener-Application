//
//  NotificationScreenView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/18/25.
//

import SwiftUI
struct NotificationScreenView: View{
    @ObservedObject var notificationsViewModel: NotificationsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Notifications")
                    .padding()
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                List(notificationsViewModel.notifications, id: \.timestamp) { notification in
                                NotificationRow(notification: notification)
                            }
                .id(UUID()) // Forces SwiftUI to refresh when notifications update
                
                            Spacer()
                }
                
                .toolbar {
                    Button ("Clear All"){
                        notificationsViewModel.clearAllNotifications()
                    }
                }
            }
        }
    }
    
    struct NotificationRow: View {
        let notification: NotificationItem //variable notification of type notificationItem
        
        var body: some View {
            VStack(alignment: .leading){
                Text(notification.title)
                    .font(.headline)
                Text(notification.message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(notification.timestamp, style:.time)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            .padding()
            
        }
    }

    
    struct NotificationScreenView_Previews: PreviewProvider {
        static var previews: some View {
            let notificationsVM = NotificationsViewModel()
                    return NotificationScreenView(notificationsViewModel: notificationsVM)
        }
    }

