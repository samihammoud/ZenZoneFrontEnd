//
//  ShakeEffect.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/4/24.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 1
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        // Calculate the offset based on sine wave
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
