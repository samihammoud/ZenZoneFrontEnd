//
//  GlisteningStarView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/3/24.
//

import SwiftUI

struct GlisteningStarsView: View {
    let starCount: Int
    let maxStarSize: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<starCount, id: \.self) { _ in
                    let x = CGFloat.random(in: 0...geometry.size.width)
                    let y = CGFloat.random(in: 0...geometry.size.height)
                    let size = CGFloat.random(in: 1...maxStarSize)
                    let duration = Double.random(in: 1.5...3.0)
                    let delay = Double.random(in: 0...2.0)

                    StarView(size: size, duration: duration, delay: delay)
                        .position(x: x, y: y)
                }
            }
            //.background(Color.black) // Optional: Set a dark sky background
            .ignoresSafeArea()
        }
    }
}

struct StarView: View {
    @State private var opacity: Double = 0.0
    let size: CGFloat
    let duration: Double
    let delay: Double

    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: size, height: size)
            .opacity(opacity)
            .animation(
                Animation.easeInOut(duration: duration)
                    .repeatForever()
                    .delay(delay),
                value: opacity
            )
            .onAppear {
                opacity = 1.0
            }
    }
}

#Preview {
    GlisteningStarsView(starCount: 50, maxStarSize: 4) // Provide required arguments
}
