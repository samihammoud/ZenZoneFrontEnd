//
//  ChatUIView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/5/24.
//
import SwiftUI

struct ChatUIView: View {
    @StateObject private var viewModel = ChatViewModel()
    private let systemPrompt = "You are a compassionate and professional therapist. Your goal is to help the user explore their feelings, identify challenges, and discover solutions or coping strategies in a supportive and non-judgmental way. Use active listening, open-ended questions, and empathetic responses to guide the conversation. Avoid giving direct advice; instead, encourage self-reflection and personal growth. Always maintain a calm and reassuring tone."

    @State private var userInput = ""
    @State private var messages: [String] = ["Bot: Hello. I am Zen, your personal therapist, here to help you with your problems. What's going on today?"]
    @State private var conversationHistory: [OpenAIChatMessage] = [
        OpenAIChatMessage(
            role: "system",
            content: "You are a compassionate and professional therapist. Your goal is to help the user explore their feelings, identify challenges, and discover solutions or coping strategies in a supportive and non-judgmental way. Use active listening, open-ended questions, and empathetic responses to guide the conversation. Avoid giving direct advice; instead, encourage self-reflection and personal growth. Always maintain a calm and reassuring tone."
        ),
        OpenAIChatMessage(
            role: "assistant",
            content: "Hello. I am Zen, your personal therapist, here to help you with your problems. What's going on today?"
        )
    ]
    @State private var isSending = false

    private let chatService = OpenAIChatService()

    var body: some View {
        VStack {
            Text("Zen Zone")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color.blue.opacity(0.2))
            ScrollView {
                ForEach(viewModel.messages) { message in
                    Text(message.displayText)
                        .padding()
                        .background(message.isUser ? Color.blue.opacity(0.2) : Color.green.opacity(0.2))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
                }
            }
            .padding()

            HStack {
                TextField("Type your message...", text: $viewModel.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)

                Button(action: {
                    viewModel.sendCurrentMessage()
                }) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.isSending || viewModel.userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding()
        }
    }

    private func sendMessage() {
        guard !userInput.isEmpty else { return }
        isSending = true
        let userMessage = userInput
        messages.append("You: \(userMessage)")
        conversationHistory.append(OpenAIChatMessage(role: "user", content: userMessage))
        userInput = ""

        chatService.sendMessage(messages: conversationHistory) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let reply):
                    messages.append("Bot: \(reply)")
                    conversationHistory.append(OpenAIChatMessage(role: "assistant", content: reply))
                case .failure(let error):
                    messages.append("Bot: Error - \(error.localizedDescription)")
                    if conversationHistory.isEmpty {
                        conversationHistory.append(OpenAIChatMessage(role: "system", content: systemPrompt))
                    }
                }
                isSending = false
            }
        }
    }
}

struct ChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatUIView()
    }
}

