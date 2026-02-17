import Foundation
import Combine

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var userInput = ""
    @Published private(set) var messages: [ChatMessage]
    @Published private(set) var isSending = false

    private let chatService: OpenAIChatService
    private var conversationHistory: [OpenAIChatMessage]
    private let maxMessagesInContext = 24

    init(chatService: OpenAIChatService = OpenAIChatService()) {
        self.chatService = chatService

        self.messages = [
            ChatMessage(message: OpenAIChatService.greeting, isUser: false)
        ]

        self.conversationHistory = [
            OpenAIChatMessage(role: "system", content: OpenAIChatService.systemPrompt),
            OpenAIChatMessage(role: "assistant", content: OpenAIChatService.greeting)
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
        conversationHistory.append(OpenAIChatMessage(role: "user", content: trimmedInput))
        trimHistoryIfNeeded()

        let requestHistory = conversationHistory
        chatService.sendMessage(messages: requestHistory) { [weak self] result in
        chatService.sendMessage(message: trimmedInput) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let reply):
                    self.messages.append(ChatMessage(message: reply, isUser: false))
                    self.conversationHistory.append(OpenAIChatMessage(role: "assistant", content: reply))
                    self.trimHistoryIfNeeded()
                case .failure(let error):
                    self.messages.append(ChatMessage(message: "Error - \(error.localizedDescription)", isUser: false))
                }
                self.isSending = false
            }
        }
    }

    private func trimHistoryIfNeeded() {
        guard conversationHistory.count > maxMessagesInContext else {
            return
        }

        let systemMessage = conversationHistory.first { $0.role == "system" }
        var conversationOnly = conversationHistory.filter { $0.role != "system" }
        conversationOnly = Array(conversationOnly.suffix(maxMessagesInContext - 1))

        if let systemMessage {
            conversationHistory = [systemMessage] + conversationOnly
        } else {
            conversationHistory = conversationOnly
        }
    }
}
