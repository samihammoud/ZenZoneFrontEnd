//
//  FavoritesView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/4/24.


import SwiftUI

struct FavoritesView: View {
    @ObservedObject var meditationHandler: MeditationHandler
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all) // Ensures the background covers the entire screen
            
            VStack {
                Text("Favorites")
                    .padding(.bottom, 200)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    // Filter the favorite meditations dynamically
                    ForEach(meditationHandler.meditationArray.filter { $0.isFavorite }) { card in
                        RoutineCardView(meditationVM: card, meditationHandler: meditationHandler)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
    }
}

#Preview {
    FavoritesView(meditationHandler: MeditationHandler())
}

