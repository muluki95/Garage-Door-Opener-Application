//
//  NotificationRepository.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/6/25.
//

import Foundation
import FirebaseFirestore



class NotificationRepository {
    private let db = Firestore.firestore()
    
    //function to add notifications
    func addNotification( _ notification: Notification) async throws {
        do{
            //await the document addition to firestore
             let ref = try await db.collection("notifications").addDocument(data: try Firestore.Encoder().encode(notification)) // Firebase.Encoder converts model object notification into a dictionary ([String:Any])
            print("Notification added with ID: \(ref.documentID)")
            
        } catch {
            print("Error adding notification: \(error.localizedDescription)")
            throw error
        }
    }
    
    //function to fetch notifications from firestore
    func fetchNotifications() async throws -> [Notification]{
        let snapshot = try await db.collection("notifications")
            .order(by:"timestamp", descending: true)
            .getDocuments()
        
        let notifications =  try snapshot.documents.compactMap {
            try $0.data(as: Notification.self)
            
        }
        print("Retrieved Notification: \(notifications)")
        return notifications
    }
}
