//
//  NowPlayingView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/4/24.
//

import SwiftUI


struct NowPlayingView: View {
    @ObservedObject var meditationVM: MeditationViewModel
    
    init(meditationVM: MeditationViewModel) {
        self.meditationVM = meditationVM
    }

    var body: some View {
        ZStack {
            // Black background
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            if meditationVM.isPlaying {
                RainView()
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
            }
            
            // Content overlay
            VStack {
                Spacer()
                Text(meditationVM.isPlaying ? "Now Playing..." : "Paused")
                    .foregroundColor(.white) // Set text color to white
                Text(meditationVM.meditation.title)
                    .foregroundColor(.white) // Set text color to white
                Spacer()
                Text(meditationVM.meditation.description)
                    .italic()
                    .foregroundColor(.green)
                    .padding()
                Spacer()
                
                Button(action: {
                    meditationVM.togglePlayback()
                }) {
                    Image(systemName: meditationVM.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 100)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(100)
                        .padding(.horizontal, 50)
                }
                .padding(.bottom, 250)
            }
            .transition(.opacity)
        }
        .onDisappear {
            if meditationVM.isPlaying {
                meditationVM.togglePlayback() // Stop playback when the view disappears
            }
        }
    }
}

#Preview {
    let dataTest = MeditationViewModel(meditation: Meditation.data)
    return NowPlayingView(meditationVM: dataTest)
}

