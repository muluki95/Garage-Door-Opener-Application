//
//  NotificationsModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/24/25.
//
import Foundation

struct Notification: Codable,Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var timestamp = Date()
}

extension Notification {
    static let testNotification = Notification (
        title: "Garage Door Opened",
        message: "Your garage door has been opened at 3.15PM"
    
    )
}
