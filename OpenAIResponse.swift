//
//  OpenAIResponse.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/6/24.
//

import SwiftUI
import Foundation

// MARK: - OpenAI API Response Models
struct OpenAIResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

struct OpenAIError: Codable {
    struct ErrorDetails: Codable {
        let message: String
        let type: String
    }
    let error: ErrorDetails
}

// MARK: - OpenAI Chat Service
class OpenAIChatService {
    private let apiKey = "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"

    func sendMessage(message: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 1, userInfo: nil)))
            return
        }
        


        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo", // or "gpt-3.5-turbo"
            "messages": [
                ["role": "system", "content": "You are a compassionate and professional therapist. Your goal is to help the user explore their feelings, identify challenges, and discover solutions or coping strategies in a supportive and non-judgmental way. Use active listening, open-ended questions, and empathetic responses to guide the conversation. Avoid giving direct advice; instead, encourage self-reflection and personal growth. Always maintain a calm and reassuring tone."]
            ],
            "temperature": 0.7
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 2, userInfo: nil)))
                return
            }

            // Debugging: Print raw response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }

            do {
                let decodedResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
                if let reply = decodedResponse.choices.first?.message.content {
                    completion(.success(reply))
                } else {
                    completion(.failure(NSError(domain: "NoReply", code: 3, userInfo: nil)))
                }
            } catch {
                // Attempt to decode an error message
                if let decodedError = try? JSONDecoder().decode(OpenAIError.self, from: data) {
                    print("OpenAI Error: \(decodedError.error.message)")
                    completion(.failure(NSError(domain: decodedError.error.message, code: 4, userInfo: nil)))
                } else {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
