//
//  MigraineDetailInfoView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct MigraineDetailInfoView: View {
    var migraineType: MigraineType

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Remove this line to avoid showing the title twice
                // Text(migraineType.title)
                //     .font(.title)
                //     .padding()

                Text(migraineType.details)
                    .padding()
            }
        }
        .navigationBarTitle(Text(migraineType.title), displayMode: .inline)  // Keep title in the navigation bar only
    }
}


