//
//  SwiftUIView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct APIKeyView: View {
    @State private var apiKey: String = UserDefaults.standard.string(forKey: "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") ?? ""

    var body: some View {
        VStack {
            Text("Enter OpenAI API Key")
                .font(.headline)
                .padding()

            TextField("API Key", text: $apiKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Save the API key in UserDefaults
                UserDefaults.standard.set(apiKey, forKey: "OpenAIAPIKey")
            }) {
                Text("Save API Key")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}
