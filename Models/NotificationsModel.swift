//
//  NotificationsModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/24/25.
//
import Foundation

struct NotificationItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let timestamp: Date
}
