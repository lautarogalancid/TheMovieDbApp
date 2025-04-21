//
//  SearchView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 19/04/2025.
//

import SwiftUICore
import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack {
            Text("Search here")
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: Add info
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .preferredColorScheme(.dark) // TODO: Handle in app style extension
        .tint(.blue)
}
