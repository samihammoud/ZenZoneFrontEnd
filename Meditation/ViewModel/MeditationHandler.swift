//
//  MeditationHandler.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/4/24.
//

import Foundation
import Combine

final class MeditationHandler: ObservableObject, Identifiable {
    @Published var isAnyPlaying: Bool = false

    @Published var meditationArray: [MeditationViewModel] = [
        MeditationViewModel(meditation: Meditation.data),
        MeditationViewModel(meditation: Meditation.data2),
        MeditationViewModel(meditation: Meditation.data3),
        MeditationViewModel(meditation: Meditation.data4)
    ]

    @Published private(set) var meditationFavoriteArray: [MeditationViewModel] = [] // Reactive array of favorites

    init() {
        updateFavorites() // Initialize the favorites array
    }

    // Update `meditationFavoriteArray` to include only favorites
    func updateFavorites() {
        meditationFavoriteArray = meditationArray.filter { $0.isFavorite }
        print("Updated favorites: \(meditationFavoriteArray.map { $0.meditation.title })")
    }
}
