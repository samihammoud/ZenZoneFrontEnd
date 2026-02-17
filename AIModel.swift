//
//  AIModel.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/5/24.

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let message: String
    let isUser: Bool

    var displayText: String {
        "\(isUser ? "You" : "Bot"): \(message)"
    }
}
