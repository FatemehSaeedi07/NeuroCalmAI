//
//  MigraineInfoView.swift
//  NeuroCalmAI
//
//  Created by Fatemeh Saeedi on 9/22/24.
//

import SwiftUI

struct MigraineInfoView: View {
    var body: some View {
        List(migraineTypes) { migraine in
            NavigationLink(destination: MigraineDetailInfoView(migraineType: migraine)) {
                HStack {
                    Image(systemName: migraine.symbol)
                        .foregroundColor(.blue)
                        .imageScale(.large)
                    VStack(alignment: .leading) {
                        Text(migraine.title)
                            .font(.headline)
                        Text(migraine.description)
                            .font(.subheadline)
                    }
                }
            }
        }
        .navigationBarTitle("Types of Migraines", displayMode: .inline)
    }
}



