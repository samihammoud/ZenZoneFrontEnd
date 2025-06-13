//
//  ChatUIView.swift
//  MeditationFinal
//
//  Created by Sami Hammoud on 12/5/24.
//
import SwiftUI

struct ChatUIView: View {
    @State private var userInput = ""
    @State private var messages: [String] = ["Bot: Hello. I am Zen, your personal therapist, here to help you with your problems. What's going on today?"]
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
                ForEach(messages, id: \.self) { message in
                    Text(message)
                        .padding()
                        .background(message.starts(with: "Bot:") ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: message.starts(with: "Bot:") ? .leading : .trailing)
                }
            }
            .padding()

            HStack {
                TextField("Type your message...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 40)

                Button(action: {
                    sendMessage()
                }) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(isSending || userInput.isEmpty)
            }
            .padding()
        }
    }

    private func sendMessage() {
        guard !userInput.isEmpty else { return }
        isSending = true
        let userMessage = userInput
        messages.append("You: \(userMessage)")
        userInput = ""

        chatService.sendMessage(message: userMessage) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let reply):
                    messages.append("Bot: \(reply)")
                case .failure(let error):
                    messages.append("Bot: Error - \(error.localizedDescription)")
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


