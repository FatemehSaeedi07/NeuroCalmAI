//
//  BreathingExerciseView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct BreathingExerciseView: View {
    @State private var isExpanded = false

    var body: some View {
        VStack {
            Text("Breathe in as the circle expands, and breathe out as it contracts.")
                .font(.largeTitle)
                .padding()

            Text("Breathing exercises help reduce migraines by lowering stress, improve oxygen flow, and activating the parasympatheitc nervous system, which promotes relaxation and reduces tension.")
                .font(.subheadline)
                .padding()

            Spacer()

            Circle()
                .frame(width: isExpanded ? 200 : 100, height: isExpanded ? 200 : 100)
                .foregroundColor(.green)
                .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true), value: isExpanded)
                .onAppear {
                    isExpanded.toggle()
                }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Calm Breathing Technique", displayMode: .inline)
    }
}


