//
//  GarageDoorViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/20/25.
//

import SwiftUI

class GarageDoorViewModel : ObservableObject {
    @Published var garageStatus = GarageDoorStatus(isOpen: false, notifications: [])
    private var notificationsViewModel: NotificationsViewModel
    
    init(notificationsViewModel: NotificationsViewModel) {
        self.notificationsViewModel = notificationsViewModel
    }
    
    
    func toggleDoor(){
        garageStatus.isOpen.toggle()
        //send notification when the door is toggled
        notificationsViewModel.addNotification(
                    title: "Garage Door Status",
                    message: garageStatus.isOpen ? "Garage door is now OPEN" : "Garage door is now CLOSED"
                )
        
    }
    
}
