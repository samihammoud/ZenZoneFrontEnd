//
//  AudioManager.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/3/24.
//

import Foundation
import AVKit

final class AudioManager {
    static let shared = AudioManager()
    //can hold a string or nill
    var player: AVAudioPlayer?
    
    func startPlayer (track: String){
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            print ("Resource not Found: \(track)")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            
            player?.play()
        } catch {
            print ("Fail to initialize player", error)
        }
    }
    
    func stopPlayer (){
        player?.pause()
    }
}
