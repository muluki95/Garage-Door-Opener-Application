//
//  VoiceControlView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/23/25.
//

import Foundation
import SwiftUI


struct VoiceControlView: View {
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel
        @EnvironmentObject var garageViewModel: GarageDoorViewModel
    @EnvironmentObject var voiceViewModel: VoiceControlViewModel
    var body: some View {
        VStack {
           
            Button(action: {
                Task{
                    //function of start listening from viewmodel
                    await voiceViewModel.startListening(garageViewModel: garageViewModel, notificationsViewModel: notificationsViewModel)
                }
            }) {
                Label("Tap To Start Voice Command ", systemImage: "mic.fill")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                
                
            }
                
            Button("Tap To Stop Voice Command", systemImage:"mic.slash.fill"){
               //function of stop listening from viewmodel
                voiceViewModel.stopListening()
            }
            .padding()
            .cornerRadius(10)
            .foregroundStyle(.white)
            .background(RoundedRectangle(cornerRadius: 10) .fill(Color.red))
            .frame(maxWidth: .infinity, minHeight: 40)
            
            
            }
        .padding()
        }
    }



struct VoiceControlView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceControlView()
            .environmentObject(VoiceControlViewModel())
    }
}
