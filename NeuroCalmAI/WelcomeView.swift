//
//  WelcomeView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 20) // Top space

                Image(systemName: "brain.head.profile")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)

                Text("Welcome to NeuroCalmAI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center) // Center the text
                    .padding(.bottom, 10)

                Text("Discover insights about migraines, connect with our NeuroGuide for personalized support, or engage in our tailored visual and breathing exercises.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                // Disclaimer in red
                Text("Disclaimer: This app is for educational purposes only and is not a substitute for professional medical advice. Always consult a healthcare provider.")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)  // make it centered
                    .padding(.horizontal)
                    .padding(.bottom, 20)

                // Navigation to Migraine Information
                NavigationLink(destination: MigraineInfoView()) {
                    Label("Explore Migraine Types", systemImage: "brain")
                        .customButtonStyle()
                }

                // Navigation to NeuroGuide
                NavigationLink(destination: ChatBotView()) {
                    Label("Connect with NeuroGuide", systemImage: "message")
                        .customButtonStyle()
                }

                // Navigation to Eye Movement Exercises
                NavigationLink(destination: EyeMovementView()) {
                    Label("Focused Eye Relaxation", systemImage: "eyebrow")
                        .customButtonStyle()
                }

                // Navigation to Breathing Exercises
                NavigationLink(destination: BreathingExerciseView()) {
                    Label("Calm Breathing Technique", systemImage: "wind")
                        .customButtonStyle()
                }

                Spacer(minLength: 50) // Bottom space to make sure nothing gets cut off
            }
            .padding(.horizontal)
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

// narrower buttons
extension View {
    func customButtonStyle() -> some View {
        self.padding()
            .frame(maxWidth: UIScreen.main.bounds.width * 0.85)  // Restrict button width to 85% of the screen width
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.vertical, 5)
    }
}










