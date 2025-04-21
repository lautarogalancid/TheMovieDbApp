//
//  SearchResultMovie.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 21/04/2025.
//

import Foundation

struct SearchResultMovie: Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String
    // TODO: Getting ids, need a handler for those, add later
    // TODO: runtime not present in response anymore?

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    var releaseYear: String {
        String(releaseDate.prefix(4))
    }
}
