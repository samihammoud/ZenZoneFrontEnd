//
//  AIModel.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/5/24.

import Foundation

// Define a ChatMessage struct with id, message, and isUser properties.
struct ChatMessage: Identifiable {
    var id = UUID()
    var message: String
    var isUser: Bool
}
