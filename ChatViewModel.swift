import Foundation
import Combine

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var userInput = ""
    @Published private(set) var messages: [ChatMessage]
    @Published private(set) var isSending = false

    private let chatService: OpenAIChatService

    init(chatService: OpenAIChatService = OpenAIChatService()) {
        self.chatService = chatService

        self.messages = [
            ChatMessage(
                message: "Hello. I am Zen, your personal therapist, here to help you with your problems. What's going on today?",
                isUser: false
            )
        ]
    }

    func sendCurrentMessage() {
        let trimmedInput = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty, !isSending else {
            return
        }

        userInput = ""
        isSending = true

        messages.append(ChatMessage(message: trimmedInput, isUser: true))
        chatService.sendMessage(message: trimmedInput) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let reply):
                    self.messages.append(ChatMessage(message: reply, isUser: false))
                case .failure(let error):
                    self.messages.append(ChatMessage(message: "Error - \(error.localizedDescription)", isUser: false))
                }
                self.isSending = false
            }
        }
    }
}
