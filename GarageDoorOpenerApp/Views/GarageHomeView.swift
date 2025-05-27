import SwiftUI

struct GarageHomeView: View {
    @ObservedObject var notificationsViewModel: NotificationsViewModel
    @ObservedObject var garageViewModel: GarageDoorViewModel
    @EnvironmentObject private var voiceViewModel:VoiceControlViewModel
    
    
    
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                // Recent Notifications (moved to the top)
                Text("Garage Control Panel")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .padding(.top)
                
                
                Image("garageImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 350)
                    //.background(Color.red)
                    .padding()
            
            Spacer()
            
            // Garage Status
            Text(garageViewModel.garageStatus.isOpen ? "Garage Door: OPEN" : "Garage Door: CLOSED")
            //.padding()
                .fontWeight(.bold)
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
        //Voice control button
            Button(action: {
                                if voiceViewModel.isListening {
                                    voiceViewModel.stopListening()
                                } else {
                                    Task {
                                        await voiceViewModel.startListening(
                                            garageViewModel: garageViewModel,
                                            notificationsViewModel: notificationsViewModel
                                        )
                                    }
                                }
                            }) {
                                HStack {
                                    Image(systemName: voiceViewModel.isListening ? "mic.slash.fill" : "mic.fill")
                                    Text(voiceViewModel.isListening ? "Stop Listening" : "Start Listening")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(voiceViewModel.isListening ? Color.red : Color.blue)
                                .cornerRadius(10)
                            }
                            .padding(.top)
                        }
                        .padding()
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear All") {
                    notificationsViewModel.clearAllNotifications()
                }
            }
            }
        }
    }

        
    
