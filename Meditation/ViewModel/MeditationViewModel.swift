//
//  MeditationViewModel.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/3/24.
//


import Foundation
final class MeditationViewModel: ObservableObject, Identifiable {
    //need unique ID for for each loop
    let id = UUID()
    //set protects data
    private(set) var meditation: Meditation
    @Published var isPlaying: Bool = false
    @Published var isFavorite: Bool

    
    //adds state management to Meditation, builds on to core raw data
    //initializing meditation model as blueprint to play with 

    init(meditation: Meditation){
        self.meditation = meditation
        self.isFavorite = meditation.isFavorite
    }
    
    //MeditationVM is of type Meditation, sets isPlaying to true
    func togglePlayback() {
        isPlaying.toggle()
        
        if isPlaying {
            print("Meditation started.")
            AudioManager.shared.startPlayer(track: meditation.track)
        } else {
            print("Meditation paused.")
            // Corrected: Removed 'track' parameter assuming stopPlayer() doesn't require it
            AudioManager.shared.stopPlayer()
        }
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
        print ("Favorited!")
    }
}

//model - defines data structure for a meditation session
struct Meditation {
    let id = UUID()
    let title: String
    let description: String
    let duration: String
    let track: String
    let isFavorite: Bool
    
    static let data = Meditation(title: "1 min Relaxing Meditation", description: "Here's a short mindfulness exercise to start the day", duration: "70", track: "meditation1", isFavorite: true)
    static let data2 = Meditation(title: "5 min Relaxing Meditation", description: "Clear your mind with this relaxing meditation", duration: "70", track: "meditation1", isFavorite: true)
    static let data3 = Meditation(title: "10 min Relaxing Meditation", description: "Generate some energy with this intense breathwork!", duration: "70", track: "meditation1", isFavorite: true)
    static let data4 = Meditation(title: "5 min Relaxing Meditation", description: "Calm your mind before bed with this routine ", duration: "70", track: "meditation1", isFavorite: false)
}
