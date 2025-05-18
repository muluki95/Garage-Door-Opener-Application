import SwiftUI

struct GarageHomeView: View {
    @ObservedObject var notificationsViewModel: NotificationsViewModel
    @ObservedObject var garageViewModel: GarageDoorViewModel
    
    
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                // Recent Notifications (moved to the top)
                Text("Garage Control Panel")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .padding(.top)
                
                
                //List(notificationsViewModel.notifications, id: \.timestamp) { notification in
                //NotificationRow(notification: notification)
            }
            
            Spacer()
            
            // Garage Status
            Text(garageViewModel.garageStatus.isOpen ? "Garage Door: OPEN" : "Garage Door: CLOSED")
            //.padding()
            //.fontWeight(.bold)
            // .font(.title2)
            
            Spacer().frame(height: 50)
            
            // Toggle Button
            Button(action: {
                garageViewModel.toggleDoor()
                
            }) {
                Text(garageViewModel.garageStatus.isOpen ? "Close Garage" : "Open Garage")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 200, height: 50)
                    .background(garageViewModel.garageStatus.isOpen ? Color.red : Color.green)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding()
            }
            .padding(.horizontal)
            
        }
        //Navigation to SettingScreenView
        
        
        //.navigationTitle("Garage Home")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear All") {
                    notificationsViewModel.clearAllNotifications()
                }
            }
        }
    }
}
        
    
