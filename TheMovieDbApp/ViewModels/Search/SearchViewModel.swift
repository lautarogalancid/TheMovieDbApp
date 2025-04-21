//
//  SearchViewModel.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 21/04/2025.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var searchPerformed = false
    @Published var movies: [SearchResultMovie] = []

    private let service: MovieServiceProtocol

    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }

    func performSearch() async {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            movies = []
            searchPerformed = false
            return
        }

        do {
            // TODO: Add infinite scroll later
            let results = try await service.searchMovies(query: trimmed, page: 1)
            self.movies = results
        } catch {
            // TODO: Handle errors properly
            self.movies = []
        }
        self.searchPerformed = true
    }
}
