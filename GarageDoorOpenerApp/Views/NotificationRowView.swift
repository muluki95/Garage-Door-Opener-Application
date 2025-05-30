//
//  NotificationScreenView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/18/25.
//

import SwiftUI

    
struct NotificationRow: View {
    typealias DeleteAction = () async throws -> Void
    let notification: Notification //variable notification of type notificationItem
    let deleteAction: DeleteAction
    
    @State private var showConfirmationDialog = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        VStack(alignment: .leading, spacing:10){
            HStack{
                VStack(alignment:.leading, spacing:10){
                    Text(notification.title)
                        .font(.headline)
                    Text(notification.message)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(notification.timestamp, style:.time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                }
                
                //.padding(.vertical)
                Spacer()
                
                Button(role: .destructive, action: {
                    showConfirmationDialog = true
                    
                }) {
                    Label("Delete", systemImage: "trash")
                }
                
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)
                .confirmationDialog("Are you sure you want to delete the notification?", isPresented: $showConfirmationDialog, titleVisibility: .visible){
                    Button("Delete", role:.destructive){
                        
                        Task{
                            do{
                                try await deleteAction()
                            }
                            catch{
                                errorMessage = error.localizedDescription
                                showErrorAlert = true
                            }
                        }
                            }
                            Button("Cancel", role:.cancel) {}
                        }
                    }
                }
        .alert("Error", isPresented: $showErrorAlert){
            Button("OK", role:.cancel){}
        } message: {
            Text(errorMessage)
        }
                
                
            }
        }
        
   

