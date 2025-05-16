//
//  FormViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/15/25.
//
import SwiftUI
import Foundation

@MainActor
@dynamicMemberLookup


class FormViewModel <Value>: ObservableObject {
    typealias Action = (Value)async throws -> Void
    
    @Published var value: Value
    @Published var error:Error?
    @Published var isWorking = false // showing progress state
    
    subscript<T>(dynamicMember keyPath:WritableKeyPath<Value,T>)-> T{
        get{value [keyPath:keyPath]}
        set{value [keyPath: keyPath] = newValue}
    }
    private let action: Action
    init(initialValue:Value, action:@escaping Action){
        self.value = initialValue
        self.action = action
    }
    private func handleSubmit() async {
        isWorking = true
        do{
            try await action(value)
        }catch {
            print("[FormViewModel] Cannot submit:\(error)")
            self.error = error
        }
        isWorking = false
    }
    //helps us use the submit method without any restrictions
    nonisolated func submit(){
        Task{
            await handleSubmit()
        }
        
    }
}
