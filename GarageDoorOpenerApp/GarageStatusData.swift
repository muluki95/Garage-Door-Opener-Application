//
//  GarageStatusData.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/2/25.
//
import Foundation

// codable structs to match the JSON

struct GarageStatusData: Codable{
    let garage: GarageState
    let notifications: [Notification]
    
}
 
struct GarageState: Codable {
    let isOpen: Bool
}
