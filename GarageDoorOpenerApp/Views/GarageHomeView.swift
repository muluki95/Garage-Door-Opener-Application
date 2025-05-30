import SwiftUI

struct GarageHomeView: View {
    @ObservedObject var notificationsViewModel: NotificationsViewModel
    @ObservedObject var garageViewModel: GarageDoorViewModel
    @EnvironmentObject private var voiceViewModel:VoiceControlViewModel
    @State private var isGarageOpen = false
    @State private var isListening = false
    @State private var showTranscriptionView = false
    
    
    
    
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
                if isListening {
                    voiceViewModel.stopListening()
                } else {
                    voiceViewModel.startListening()
                    showTranscriptionView = true
                }
                isListening.toggle()
            }) {
                Label(isListening ? "Stop Listening" : "Activate Voice Command", systemImage: isListening ? "mic.slash" : "mic")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isListening ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
        }
        .navigationDestination(isPresented : $showTranscriptionView){
            TranscriptionView()
                .environmentObject(voiceViewModel)
        }
        .padding()
        .onAppear {
            voiceViewModel.onCommandRecognized = { command in
                DispatchQueue.main.async {
                    if command.lowercased().contains("open garage") {
                            garageViewModel.openDoorWithVoice()
                            showTranscriptionView = false
                        } else if command.lowercased().contains("close garage") {
                            garageViewModel.closeDoorWithVoice()
                           showTranscriptionView = false
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear All") {
                    notificationsViewModel.clearAllNotifications()
                }
            }
        }
    }
}


    
