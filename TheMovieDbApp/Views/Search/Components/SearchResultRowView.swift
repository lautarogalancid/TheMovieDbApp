//
//  SearchResultRowView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 21/04/2025.
//


import SwiftUI

struct SearchResultRowView: View {
    let title: String
    let posterURL: URL?
    let voteAverage: Double
    let releaseYear: String
    let cache: MovieCacheProtocol
    
    init(title: String,
         posterURL: URL?,
         voteAverage: Double,
         releaseYear: String,
         cache: MovieCacheProtocol = MovieCache()) {
        self.title = title
        self.posterURL = posterURL
        self.voteAverage = voteAverage
        self.releaseYear = releaseYear
        self.cache = cache
    }

    var body: some View {
        HStack(spacing: 16) {
            MoviePosterView(
                imageUrl: posterURL,
                height: 120,
                width: 80,
                cache: cache
            )

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
                    .lineLimit(2)

                Label(String(format: "%.1f", voteAverage), systemImage: "star.fill")
                Label(releaseYear, systemImage: "calendar")
            }
            .font(.system(size: 18))
            .foregroundStyle(.white)
            .lineLimit(1)

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SearchResultRowView(
        title: "The Matrix Reloaded",
        posterURL: URL(string: "https://image.tmdb.org/t/p/w500/5VVb6hZL0U6FdNFFoCkfyZqH1kR.jpg"),
        voteAverage: 7.8,
        releaseYear: "2003"
    )
    .preferredColorScheme(.dark)
    .padding()
    .background(Color.black)
}
