//
//  AudioService.swift
//  GiphyApp
//
//  Created by Fed on 29.03.2023.
//

import Foundation
import AVFoundation

final class AudioService {
    
    var audioPlayer: AVAudioPlayer
    
    private enum Song {
        static let name = "surfinBird"
        static let type = "mp3"
    }
    
    init(audioPlayer: AVAudioPlayer = AVAudioPlayer()) {
        self.audioPlayer = audioPlayer
    }
    
    func playAudioLoop() {
        guard let audioPath = Bundle.main.path(forResource: Song.name, ofType: Song.type) else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            audioPlayer.numberOfLoops = -1 
            audioPlayer.play()
        } catch {
            debugPrint("Error playing audio: \(error.localizedDescription)")
        }
    }
}
