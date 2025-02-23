//
//  EyeMovementView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct EyeMovementView: View {
    @State private var moveLeftRight = false

    var body: some View {
        VStack {
            Text("Follow the dot with your eyes as it moves from side to side.")
                .font(.largeTitle)
                .padding()

            Text("Eye movement exercises help alleviate migraine-related tension by relaxing eye muscles, improving visual coordination, and reducing neurological strain that can trigger headaches.")
                .font(.subheadline)
                .padding()

            Spacer()

            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .offset(x: moveLeftRight ? -150 : 150)
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: moveLeftRight)
                .onAppear {
                    moveLeftRight.toggle()
                }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Focused Eye Relaxation", displayMode: .inline)
    }
}


