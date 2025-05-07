//
//  NotificationsViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/24/25.
//

import Foundation
import FirebaseFirestore

class NotificationsViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    
    private let repository:NotificationRepository
    
    init(repository:NotificationRepository){
        self.repository = repository
    }
    
    func addNotification(title:String, message:String){
        let newNotification = Notification(title:title, message:message, timestamp:Date())
        notifications.insert(newNotification, at:0) //adds the new notification at the top of the list
        //print("✅ Notification Added: \(newNotification.title) - \(newNotification.message)")
        
        Task{
            do{
                try await repository.addNotification(newNotification)
                print("Notification added to Firestore")
                
            }catch{
                print("Failed to add notification:\(error.localizedDescription)")
                
            }
        }
    }
    
    
    func clearAllNotifications(){
        notifications.removeAll()
    }
}
