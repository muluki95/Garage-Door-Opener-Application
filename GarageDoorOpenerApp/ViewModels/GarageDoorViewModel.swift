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
        //loadGarageData()
    }
    
    
    func toggleDoor(){
        garageStatus.isOpen.toggle()
        //send notification when the door is toggled
        notificationsViewModel.addNotification(
                    title: "Garage Door Status",
                    message: garageStatus.isOpen ? "Garage door is now OPEN" : "Garage door is now CLOSED"
                )
        
    }
    //helps to load data at startup from a bundled JSON file and also synced JSON-loaded notifications with the notificationsViewModel
    func loadGarageData() -> GarageStatusData? {
        guard let url = Bundle.main.url(forResource: "garage_data", withExtension:"json"),
                let data = try? Data(contentsOf: url) else {
            print("Could not load JSON file.")
            return nil
        }

            let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // to match the date format in the NotificationItem
        do{
            let decodedData = try decoder.decode (GarageStatusData.self, from: data)
            
            //update the garage status and notifications
            DispatchQueue.main.async {
                self.garageStatus.isOpen = decodedData.garage.isOpen
                self.notificationsViewModel.notifications = .loaded(decodedData.notifications)
            }
            return decodedData
        }catch {
            print("Failed to decode JSON : \(error)")
            return nil
        }
    }
    
}
