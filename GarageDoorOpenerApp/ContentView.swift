//
//  ContentView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 3/18/25.
//

import SwiftUI
import ToastUI
import Firebase


struct ContentView: View {
    @State private var showToast = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel
    @EnvironmentObject var garageViewModel: GarageDoorViewModel
    @EnvironmentObject var voiceControlViewModel: VoiceControlViewModel
    
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                MainTabView()
            }else {
                SignInView()
            }
        }
        .onAppear {
            print("Current session: \(String(describing: viewModel.userSession?.uid))")
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            // Inject manually for preview only
            let repository = NotificationRepository()
            let notificationsVM = NotificationsViewModel(repository: repository)
            let garageVM = GarageDoorViewModel(notificationsViewModel: notificationsVM)
            let authVM = AuthViewModel()
            
            ContentView()
                .environmentObject(authVM)
                .environmentObject(notificationsVM)
                .environmentObject(garageVM)
                .environmentObject(VoiceControlViewModel())
        }
}
