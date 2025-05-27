//
//  VoiceControlViewModel.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/23/25.
//

import Foundation
import Speech
import AVFoundation

@MainActor
class VoiceControlViewModel: ObservableObject {
    @Published var recognizedText: String = ""
    @Published var isListening: Bool = false
    
    private let speechRecognizer = SFSpeechRecognizer() //sets up the speech recognizer to understand what the user is saying
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // sends live audio input to speech recognizer
    private var recognitionTask: SFSpeechRecognitionTask? // task that will process the audio and return text
    private let audioEngine = AVAudioEngine()  //handles live audio from the microphone
    
    
    
    
    
    func startListening(garageViewModel: GarageDoorViewModel, notificationsViewModel: NotificationsViewModel) async{
        
        guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
                print("Speech recognizer is not available")
                return
            }
        //asks for permission for the user to use speech recognition
        let authStatus = await withCheckedContinuation {continuation in
            SFSpeechRecognizer.requestAuthorization {status in
                continuation.resume(returning: status)
            }
        }
        //if user did not grant permission it prints an error
        guard authStatus == .authorized else {
            print("Speech recognition authorization not granted")
            return
            }
        
        if audioEngine.isRunning {
               stopListening()
           }
        
        do{
            //cancel any existing tasks to avoid overlap
            recognitionTask?.cancel()
            recognitionTask = nil
            
            //setup the audio session
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            //setup recongition request(to send audio data to Apple's speech service)
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else {
                print("Unable to create recognition request")
                            return
            }
            recognitionRequest.shouldReportPartialResults = true

                    // Setup audio engine
                    let inputNode = audioEngine.inputNode
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                        recognitionRequest.append(buffer)
                    }
                    // prepares and starts the audio engine so the mic starts listening
                    audioEngine.prepare()
                    try audioEngine.start()
                    isListening = true

                    // Start recognition from data from mic
                    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self]result, error in
                        guard let self = self  else { return } // unwraps self safely
                        
                        if let error = error {
                            print("Recognition error: \(error.localizedDescription)")
                            return
                                    }
                        guard let result = result else { return }

                        let command = result.bestTranscription.formattedString.lowercased()
                        self.recognizedText = command

                        if command.contains("open garage") {
                            garageViewModel.garageStatus.isOpen = true
                            notificationsViewModel.addNotification(title: "Garage Door Status", message: "Garage Door is now OPEN")
                        } else if command.contains("close garage") {
                            garageViewModel.garageStatus.isOpen = false
                            notificationsViewModel.addNotification(title: "Garage Door Status", message: "Garage Door is now CLOSED")
                        }

                        if result.isFinal {
                            self.stopListening()
                        }
                    }
            
        } catch {
            print("Failed to start speech recognition: \(error.localizedDescription)")
        }
            
    }
    
    
    func stopListening() {
        recognitionTask?.cancel()
            recognitionTask = nil
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            
            let audioSession = AVAudioSession.sharedInstance()
            try? audioSession.setActive(false, options: .notifyOthersOnDeactivation)
            
            isListening = false
    }
}
