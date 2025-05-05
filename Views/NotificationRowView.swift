//
//  NotificationScreenView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/18/25.
//

import SwiftUI

    
struct NotificationRow: View {
        let notification: Notification //variable notification of type notificationItem
        
        var body: some View {
            VStack(alignment: .leading){
                Text(notification.title)
                    .font(.headline)
                Text(notification.message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(notification.timestamp, style:.time)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            .padding(.vertical)
            
        }
    }

struct NotificationRow_Previews:PreviewProvider {
    static var previews: some View{
        List{
            NotificationRow(notification: Notification.testNotification)
        }
    }
}

    
   

