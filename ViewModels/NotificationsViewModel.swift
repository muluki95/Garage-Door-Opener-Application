//
//  NotificationsViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/24/25.
//

import Foundation

class NotificationsViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    
    func addNotification(title:String, message:String){
        let newNotification = NotificationItem(title:title, message:message, timestamp:Date())
        notifications.insert(newNotification, at:0) //adds the new notification at the top of the list
        //print("✅ Notification Added: \(newNotification.title) - \(newNotification.message)")
    }
    
    
    func clearAllNotifications(){
        notifications.removeAll()
    }
}
