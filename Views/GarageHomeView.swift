import SwiftUI

struct GarageHomeView: View {
    @ObservedObject var notificationsViewModel: NotificationsViewModel
    @ObservedObject var garageViewModel: GarageDoorViewModel
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Recent Notifications (moved to the top)
                Text("Recent Notifications")
                    .font(.headline)
                    .padding(.top)
                
                List(notificationsViewModel.notifications, id: \.timestamp) { notification in
                    NotificationRow(notification: notification)
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
                // Navigate to NotificationScreenView
                                NavigationLink(destination: NotificationScreenView(notificationsViewModel: notificationsViewModel)) {
                                    Text("View Notifications")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                //Navigation to SettingScreenView
                NavigationLink(destination: SettingsScreenView(viewModel: viewModel)) {
                    Text("Settings")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .navigationBarItems(trailing: Button("Clear All") {
                notificationsViewModel.clearAllNotifications()
            })
        }
    }
    
    
}

struct GarageHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let notificationsVM = NotificationsViewModel()
                let garageVM = GarageDoorViewModel(notificationsViewModel: notificationsVM)
                
                return GarageHomeView(notificationsViewModel: notificationsVM, garageViewModel: garageVM)
            
            
    }
}
