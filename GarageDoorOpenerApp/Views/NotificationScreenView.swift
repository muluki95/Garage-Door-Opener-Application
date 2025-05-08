//
//  NotificationScreenView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/6/25.
//

import SwiftUI

struct NotificationScreenView: View {
    @StateObject var notificationsVM: NotificationsViewModel

    var body: some View {
        NotificationList(notificationsViewModel: notificationsVM)
            //.navigationTitle("Notifications")
    }
}
