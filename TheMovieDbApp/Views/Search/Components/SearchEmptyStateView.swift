//
//  SearchEmptyStateView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 21/04/2025.
//

import SwiftUI

struct SearchEmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundStyle(.gray)

            Text("We're sorry, we can not find the movie :(")
                .font(.headline)
                .multilineTextAlignment(.center)

            Text("Find your movie by Type title, categories, years, etc.")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SearchEmptyStateView()
        .preferredColorScheme(.dark)
}
