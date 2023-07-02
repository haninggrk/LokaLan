//
//  SpeechToTextView.swift
//  LokaLan
//
//  Created by Andreas Lim on 30/06/23.
//

import SwiftUI
import AVFoundation

struct SpeechToTextView: View {
    @State private var transcript = "Mendengarkan ..."
    @StateObject private var wordList = WordViewModel.shared
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @Environment(\.dismiss) private var dismiss
    @State private var history: [String] = []
    
    @Binding var searchText:String
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.5, CGFloat(level) + 30) / 2 // between 0.1 and 25
        
        return CGFloat(level * (150 / 25))
        // scaled to max at 300 (our height of our bar)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(speechRecognizer.transcript == "" ? "Mendengarkan ...":"\(speechRecognizer.transcript)")
                .font(.title3)
                .foregroundColor(.blue)
            HStack() {
                Spacer()
                ForEach(wordList.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level: level))
                }
                Spacer()
            }
            .frame(height: 64)
            .cornerRadius(20)
            Spacer()
        }
        .onAppear(){
            startSpeech()
        }
        .onDisappear {
            endSpeech()
        }
        .padding()
        .padding(.top)
        .ignoresSafeArea(.all)
    }
    
    private func startSpeech() {
        wordList.startRecording()
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = false
    }
    
    private func resetSpeech() {
        speechRecognizer.resetTranscript()
    }
    
    private func endSpeech() {
        wordList.stopRecording()
        speechRecognizer.stopTranscribing()
        searchText = speechRecognizer.transcript
        isRecording = true
    }
}

struct SpeechToTextView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechToTextView(searchText: .constant(""))
    }
}
