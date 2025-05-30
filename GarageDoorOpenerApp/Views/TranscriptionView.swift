//
//  TranscriptionView.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/30/25.
//

import Foundation
import SwiftUI



struct TranscriptionView: View {
    @EnvironmentObject var viewModel: VoiceControlViewModel

    
    var body : some View {
        VStack {
            Text("Listening")
                .font(.title)
                .fontWeight(.bold)
            
            Text(viewModel.recognizedText)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity, alignment:.leading)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Voice Transcription")
    }
}
