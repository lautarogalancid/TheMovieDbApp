//
//  HomeViewModel.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import SwiftUI

// TODO: Add protocol

@MainActor
class HomeViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var gridMovies: [Movie] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    @Published var selectedMovieDetails: MovieDetail?
    
    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }
    
    func loadPopularMovies() async {
        do {
            // TODO: Use correct endpoint
            let movies = try await service.fetchPopular()
            popularMovies = Array(movies.prefix(5))
        } catch {
            // TODO: Handle error, snack? alert?
            errorMessage = error.localizedDescription
        }
    }
    
    func loadGridMovies(for category: Categories) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let movies: [Movie]
            switch category {
            case .nowPlaying:
                movies = try await service.fetchNowPlaying()
            case .upcoming:
                movies = try await service.fetchUpcoming()
            case .topRated:
                movies = try await service.fetchTopRated()
            }
            gridMovies = Array(movies.prefix(6))
        }
        catch {
            // TODO: Handle error, snack? alert?
            errorMessage = error.localizedDescription
        }
    }
    
    func selectMovie(_ movie: Movie) async {
        do {
            let detail = try await service.fetchMovieDetails(id: movie.id)
            selectedMovieDetails = detail
        } catch {
            // TODO: Handle error, snack? alert?
            errorMessage = error.localizedDescription
        }
    }
}
