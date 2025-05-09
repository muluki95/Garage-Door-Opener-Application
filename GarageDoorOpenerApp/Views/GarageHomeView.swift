import SwiftUI

struct GarageHomeView: View {
    @ObservedObject var notificationsViewModel: NotificationsViewModel
    @ObservedObject var garageViewModel: GarageDoorViewModel
    @StateObject var viewModel = SettingsViewModel()
    
    
    
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
            // Navigate to NotificationList view
            NavigationLink(destination: NotificationList(notificationsViewModel: notificationsViewModel)) {
                Text("View Notifications")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
           // }
        }
        //Navigation to SettingScreenView
        NavigationLink(destination: SettingsScreenView()) {
            Text("Settings")
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
        }
    
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
        
    }
    



struct GarageHomeView_Previews: PreviewProvider {
    static var previews: some View {
        //dummyrepository
        let repository = NotificationRepository()
        let notificationsVM = NotificationsViewModel(repository:repository)
                let garageVM = GarageDoorViewModel(notificationsViewModel: notificationsVM)
                
                return GarageHomeView(notificationsViewModel: notificationsVM, garageViewModel: garageVM)
            .environmentObject(SettingsViewModel())
            
    }
}
