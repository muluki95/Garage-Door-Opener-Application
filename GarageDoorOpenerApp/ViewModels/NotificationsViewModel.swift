//
//  NotificationsViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/24/25.
//

import Foundation
import FirebaseFirestore

class NotificationsViewModel: ObservableObject {
    @Published var notifications: Loadable<[Notification]> = .loading
    @Published var errorMessage: String?
    
    
    private let repository:NotificationRepository
    
    init(repository:NotificationRepository){
        self.repository = repository
    }
    
    func addNotification(title:String, message:String){
        let newNotification = Notification(title:title, message:message, timestamp:Date())
        
        if case.loaded(var current) = notifications{
            current.insert(newNotification, at:0)
            notifications = .loaded(current)
        }
        //notifications.insert(newNotification, at:0) //adds the new notification at the top of the list
        //print("✅ Notification Added: \(newNotification.title) - \(newNotification.message)")
        
        Task{
            do{
                try await repository.addNotification(newNotification)
                print("Notification added to Firestore")
                
            }catch{
                errorMessage = error.localizedDescription
            }
        }
    }
    
    //function to fetch notifications from firestore
    
    func fetchNotifications() async {
        Task{
            do{
                let data = try await repository.fetchNotifications()
                notifications = .loaded(data)
            } catch {
                notifications = .error(error)
                errorMessage = error.localizedDescription
            }
        }
    }
    //factory function for deleting notifications
    
    func makeDeleteAction(for notification: Notification, withAnimation: Bool = false) -> NotificationRow.DeleteAction {
        return {[weak self] in
            try await self?.repository.delete(notification)
            if case .loaded(var current) = self?.notifications {
                current.removeAll {$0.id == notification.id}
                self?.notifications = .loaded(current)
            }
        }
    }
        
        //function to clear all the notifications on the list
    func clearAllNotifications(){
        if case.loaded = notifications {
            notifications = .empty
        }
        }
    }

