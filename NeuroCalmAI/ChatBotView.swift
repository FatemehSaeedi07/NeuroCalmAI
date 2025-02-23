//
//  ChatBotView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct ChatBotView: View {
    @AppStorage("openAIAPIKey") var apiKey: String = "" // Retrieve stored API key
    @State private var userInput: String = ""
    @State private var chatMessages: [ChatMessage] = [
        ChatMessage(role: .assistant, content: "Hello! Welcome to NeuroGuide. I'm here to assist you in managing your migraines."),
        ChatMessage(role: .assistant, content: "Please remember, this advice is for educational purposes only and is not a substitute for professional medical advice."),
        ChatMessage(role: .assistant, content: """
        Let's get started! To help me assist you better, can you please answer the following questions:
        1. How often do you experience migraines?
        2. How long do your migraines usually last?
        3. What symptoms do you experience during a migraine (e.g., pain, nausea, sensitivity to light)?
        4. Do you know what triggers your migraines (e.g., stress, certain foods)?
        5. Have you tried any treatments or medications so far?
        6. Have you been diagnosed by a healthcare professional for your migraines?
        7. Do you have any other health conditions?
        """)
    ]
    @State private var isLoading = false
    @State private var showAPIKeyView = false
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            // Replace this debug text with a simple status indicator
            Circle()
                .fill(apiKey.isEmpty ? Color.red : Color.green)
                .frame(width: 10, height: 10)
                .padding(.top, 5)

            ScrollViewReader { scrollView in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(chatMessages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                    }
                }
                .padding()
                .onChange(of: chatMessages.count) { _ in
                    // Scroll to the latest message
                    if let lastMessage = chatMessages.last {
                        scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }

            if isLoading {
                ProgressView("Loading response...")
                    .padding()
            }

            HStack {
                TextField("Type your message here...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 10)
                    .disabled(apiKey.isEmpty) // Disable input if API key is missing

                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(apiKey.isEmpty ? Color.gray : Color.blue)
                        .padding()
                }
                .disabled(userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || apiKey.isEmpty)
            }
            .padding()
        }
        .navigationBarTitle("NeuroGuide", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            showAPIKeyView = true
        }) {
            Image(systemName: "key.fill")
        })
        .sheet(isPresented: $showAPIKeyView) {
            APIKeyView()
        }
        .alert(isPresented: Binding<Bool>(
            get: { errorMessage != nil },
            set: { _ in errorMessage = nil }
        )) {
            Alert(title: Text("Error"),
                  message: Text(errorMessage ?? "Unknown error"),
                  dismissButton: .default(Text("OK")))
        }
    }

    // Function to send user message
    func sendMessage() {
        let trimmedInput = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty else { return }

        let userMessage = ChatMessage(role: .user, content: trimmedInput)
        chatMessages.append(userMessage)
        userInput = ""
        isLoading = true

        fetchGPTResponse()
    }

    // Function to fetch response from OpenAI API
    func fetchGPTResponse() {
        guard !apiKey.isEmpty else {
            errorMessage = "API Key is not configured. Please check your settings."
            isLoading = false
            return
        }

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Set headers
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Prepare messages for the API, including the system prompt
        let systemMessage = APIChatMessage(role: .system, content: """
        You are a professional medical assistant specialized in migraine management. Provide accurate, empathetic, and evidence-based responses. Ensure all advice is for educational purposes and not a substitute for professional medical consultation.
        """)

        // Filter out assistant messages to avoid sending multiple assistant messages without user input
        let userMessages = chatMessages.filter { $0.role == .user }
        let apiMessages = [systemMessage] + userMessages.map { APIChatMessage(role: $0.role, content: $0.content) }

        let body: [String: Any] = [
            "model": "gpt-4",
            "messages": apiMessages.map { ["role": $0.role.rawValue, "content": $0.content] },
            "max_tokens": 500,
            "temperature": 0.7,
            "n": 1
            // "stop" parameter removed
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            DispatchQueue.main.async {
                errorMessage = "Failed to process your request."
                isLoading = false
            }
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            defer { DispatchQueue.main.async { isLoading = false } }

            if let error = error {
                print("Error fetching response: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    errorMessage = "Invalid response from server."
                }
                return
            }

            // Log the HTTP status code
            print("HTTP Status Code: \(httpResponse.statusCode)")

            guard (200...299).contains(httpResponse.statusCode) else {
                // Attempt to parse error message from response
                if let data = data, let apiError = try? JSONDecoder().decode(OpenAIAPIError.self, from: data) {
                    DispatchQueue.main.async {
                        errorMessage = "Error \(apiError.error.code ?? 0): \(apiError.error.message)"
                    }
                    print("API Error: \(apiError.error.message)")
                } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    // Log raw response
                    print("Raw Error Response:\n\(responseString)")
                    DispatchQueue.main.async {
                        errorMessage = "Server returned status code \(httpResponse.statusCode)."
                    }
                } else {
                    DispatchQueue.main.async {
                        errorMessage = "Server returned status code \(httpResponse.statusCode)."
                    }
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received from the server."
                }
                return
            }

            do {
                // Decode the response
                let apiResponse = try JSONDecoder().decode(OpenAIChatResponse.self, from: data)
                if let responseMessage = apiResponse.choices.first?.message.content {
                    let botMessage = ChatMessage(role: .assistant, content: responseMessage.trimmingCharacters(in: .whitespacesAndNewlines))
                    DispatchQueue.main.async {
                        chatMessages.append(botMessage)
                    }
                    print("Bot Response:\n\(responseMessage)")
                } else {
                    DispatchQueue.main.async {
                        errorMessage = "Failed to parse response from server."
                    }
                    print("Failed to parse response.")
                }
            } catch {
                // Print raw response for debugging
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw Response:\n\(responseString)")
                }
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    errorMessage = "Failed to process server response."
                }
            }
        }.resume()
    }
}

// Define the roles for chat messages
enum MessageRole: String, Codable {
    case system
    case user
    case assistant = "assistant" // Changed from .bot to .assistant
}

// Represents the message structure for the OpenAI API
struct APIChatMessage: Codable {
    let role: MessageRole
    let content: String
}

// Represents the message within the UI
struct ChatMessage: Identifiable {
    let id = UUID()
    let role: MessageRole
    let content: String
}

// Define the response structure from OpenAI
struct OpenAIChatResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage

    struct Choice: Codable {
        let index: Int
        let message: APIChatMessage
        let finish_reason: String?
    }

    struct Usage: Codable {
        let prompt_tokens: Int
        let completion_tokens: Int
        let total_tokens: Int
    }
}

// Define the error response structure from OpenAI
struct OpenAIAPIError: Codable {
    struct ErrorDetail: Codable {
        let message: String
        let type: String
        let param: String?
        let code: Int?
    }

    let error: ErrorDetail
}

// View for displaying chat bubbles
struct ChatBubble: View {
    var message: ChatMessage

    var body: some View {
        HStack {
            if message.role == .assistant {
                VStack(alignment: .leading) {
                    Text(message.content)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
            } else {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(message.content)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
            }
        }
        .padding(message.role == .assistant ? .leading : .trailing, 10)
    }
}

struct ChatBotView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatBotView()
        }
    }
}
