//
//  ContentView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WelcomeView()  // Navigates to Welcome Screen
        }
        .navigationViewStyle(StackNavigationViewStyle())  // checks proper behavior on iPad and iPhone
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


