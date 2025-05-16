//
//  Untitled.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/16/25.
//
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration:Configuration) -> some View {
        Group{
            if isEnabled {
                configuration.label
            } else {
                ProgressView()
            }
        }
        .padding()
        .frame(maxWidth:.infinity)
        .foregroundColor(.blue)
        .cornerRadius(20)
        .animation(.default, value:isEnabled)
    }
}
