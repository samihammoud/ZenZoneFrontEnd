//
//  RainView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/4/24.
//

import SwiftUI

struct RainView: View {
    // Raindrop model
    struct Raindrop: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var length: CGFloat
        var opacity: Double
        var speed: Double
    }
    
    @State private var raindrops: [Raindrop] = []
    
    let numberOfDrops = 100
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(raindrops) { drop in
                    Rectangle()
                        .fill(Color.white.opacity(drop.opacity))
                        .frame(width: 2, height: drop.length)
                        .position(x: drop.x, y: drop.y)
                        .animation(Animation.linear(duration: drop.speed).repeatForever(autoreverses: false), value: drop.y)
                        .onAppear {
                            // Move the raindrop to the bottom
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation {
                                    if let index = raindrops.firstIndex(where: { $0.id == drop.id }) {
                                        raindrops[index].y = geometry.size.height + 10
                                    }
                                }
                            }
                        }
                }
            }
            .onAppear {
                // Initialize raindrops
                raindrops = (0..<numberOfDrops).map { _ in
                    Raindrop(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: CGFloat.random(in: -geometry.size.height...0),
                        length: CGFloat.random(in: 5...15),
                        opacity: Double.random(in: 0.3...0.7),
                        speed: Double.random(in: 2...5)
                    )
                }
            }
            .onDisappear {
                raindrops.removeAll()
            }
        }
        .clipped()
    }
}

struct RainView_Previews: PreviewProvider {
    static var previews: some View {
        RainView()
            .background(Color.black)
            .previewLayout(.fixed(width: 300, height: 600))
    }
}
