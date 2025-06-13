//
//  RoutineCardView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/4/24.
//

import SwiftUI

struct RoutineCardView: View {
    // Giving blueprint for how one routineCard should look
    
    // Using ObservedObject to subscribe to published changes
    @ObservedObject var meditationVM: MeditationViewModel
    @ObservedObject var meditationHandler: MeditationHandler

    
    // State variable to drive the shake animation
    @State private var shakeTrigger: CGFloat = 0

    var body: some View {
        VStack {
            Text(meditationVM.meditation.title)
                .foregroundColor(.white)
                .padding()
                .fontWeight(.semibold)
            Favorite(meditationVM: meditationVM, meditationHandler: meditationHandler)
            Spacer()
            HStack {
                Text("\(meditationVM.meditation.duration) s")
                    .font(.caption2) // Make the text even smaller
                    .fontWeight(.semibold)
                    .padding(5) // Reduced padding for smaller text
                    .foregroundColor(Color.white)
                    .background(Color.gray.opacity(0.2)) // Add opaque background for the border
                    .cornerRadius(10) // Rounded corners
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1) // Opaque border
                    )
                    .padding(.leading)
                
                Spacer()
                PlayButton(meditationVM: meditationVM)
            }
            .padding(.trailing)
        }
        .frame(width: 150, height: 220)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(30)
    }
}


struct Favorite: View {
    @ObservedObject var meditationVM: MeditationViewModel
    @ObservedObject var meditationHandler: MeditationHandler


    var body: some View {
        Button(action: {
            meditationVM.toggleFavorite()
            meditationHandler.updateFavorites()
            print("toggle!")
        }) {
            Image(systemName: meditationVM.isFavorite ? "star.fill" : "star")
                .foregroundColor(meditationVM.isFavorite ? .yellow : .gray)
        }
    }
}


struct PlayButton: View {
    @ObservedObject var meditationVM: MeditationViewModel
        var body: some View {
            NavigationLink(destination: NowPlayingView(meditationVM: meditationVM)) {
                HStack {
                    Image(systemName: "play.fill" )
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray.opacity(0.2)) // Add opaque background for the border
                        .cornerRadius(25) // Circular border for play button
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.5), lineWidth: 1) // Opaque border
                        )
                }
            }
            .padding(10)
    }
}





struct RoutineCardView_Previews: PreviewProvider {
    static var previews: some View {
        let playStateVM = MeditationViewModel(meditation: Meditation.data)
        playStateVM.isPlaying = false
        
        let pauseStateVM = MeditationViewModel(meditation: Meditation.data)
        pauseStateVM.isPlaying = true

        return Group {
            // Play State Preview
            RoutineCardView(meditationVM: playStateVM, meditationHandler: MeditationHandler())
                .previewDisplayName("Play State")
            
            // Pause State Preview
            RoutineCardView(meditationVM: pauseStateVM, meditationHandler: MeditationHandler())
                .previewDisplayName("Pause State")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
