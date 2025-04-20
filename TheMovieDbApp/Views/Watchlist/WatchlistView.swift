//
//  WatchlistView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 19/04/2025.
//

import SwiftUICore
import SwiftUI

struct WatchlistView: View {
    var body: some View {
        VStack {
            Text("Watchlist here")
        }
        .navigationTitle("Watch List")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        WatchlistView()
    }
}
