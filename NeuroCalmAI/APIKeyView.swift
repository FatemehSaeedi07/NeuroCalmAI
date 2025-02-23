//
//  APIKeyView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct APIKeyView: View {
    @AppStorage("openAIAPIKey") var apiKey: String = ""  // Persistent storage for API key
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            Text("OpenAI API Key")
                .font(.headline)
                .padding()

            if apiKey.isEmpty {
                Text("API Key not found in configuration.")
                    .foregroundColor(.red)
                    .padding()
            } else {
                // confirmation message only
                Text("API Key loaded successfully.")
                    .foregroundColor(.green)
                    .padding()

                // provide a button to reload the API key
                Button(action: {
                    loadAPIKey()
                }) {
                    Text("Reload API Key")
                        .foregroundColor(.blue)
                }
                .padding()
            }

            Spacer()
        }
        .padding()
        .onAppear {
            loadAPIKey()
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Error"),
                  message: Text(errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }

    // Function to load the API key from the .env file
    func loadAPIKey() {
        if let key = EnvManager.getAPIKey() {
            apiKey = key
        } else {
            errorMessage = "Failed to load OpenAI API Key from configuration. Please ensure the key is set correctly."
            showError = true
        }
    }
}

struct APIKeyView_Previews: PreviewProvider {
    static var previews: some View {
        APIKeyView()
    }
}
