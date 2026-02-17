//
//  SeeMoreMeditationsView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/4/24.
//

import SwiftUI

struct SeeMoreMeditationsView: View {
    @ObservedObject var meditationHandler: MeditationHandler
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            // Background color for the entire screen
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("All Meditations")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.bottom, 200)
                
                LazyVGrid(columns: columns) {
                    // Filter the favorite meditations dynamically
                    ForEach(meditationHandler.meditationArray) { card in
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
    SeeMoreMeditationsView(meditationHandler: MeditationHandler())
}
