import Foundation
import Speech
import SwiftUI

class VoiceControlViewModel: ObservableObject {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    @Published var recognizedText: String = ""
    var onCommandRecognized: ((String) -> Void)?

    func startListening() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == .authorized {
                DispatchQueue.main.async {
                    self.startSession()
                }
            } else {
                print("Speech recognition not authorized")
            }
        }
    }

    func startSession() {
        recognitionTask?.cancel()
        recognitionTask = nil

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session setup error: \(error.localizedDescription)")
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode

        guard let recognitionRequest = recognitionRequest else {
            print("Unable to create request")
            return
        }

        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                let transcript = result.bestTranscription.formattedString
                DispatchQueue.main.async {
                    self.recognizedText = transcript
                    self.handleCommand(transcript)
                }
            }
            if error != nil || (result?.isFinal ?? false) {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try? audioEngine.start()
    }

    func stopListening() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }

    private func handleCommand(_ command: String) {
        let lower = command.lowercased()

        if lower.contains("open garage") || lower.contains("close garage") {
            onCommandRecognized?(lower)
        }
    }
}
