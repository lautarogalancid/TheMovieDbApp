//
//  MovieService.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//
import Foundation

protocol MovieServiceProtocol {
    func fetchPopular() async throws -> [Movie]
    func fetchNowPlaying() async throws -> [Movie]
    func fetchUpcoming() async throws -> [Movie]
    func fetchTopRated() async throws -> [Movie]
}

enum MovieEndpoints: String {
    case popular = "popular"
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case topRated = "top_rated"
}

class MovieService: MovieServiceProtocol {
    private let publicApiKey = "1fec327a16dfa43c4d0c3c78cd7d8c4d" // TODO: Define better placement for api key
    private let session: URLSession
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let nowPlayingPath = "movie/now_playing"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - MovieServiceProtocol
    func fetchPopular() async throws -> [Movie] {
        try await fetchMovies(endpoint: MovieEndpoints.popular.rawValue)
    }
    
    func fetchNowPlaying() async throws -> [Movie] {
        try await fetchMovies(endpoint: MovieEndpoints.nowPlaying.rawValue)
    }
    
    func fetchUpcoming() async throws -> [Movie] {
        try await fetchMovies(endpoint: MovieEndpoints.upcoming.rawValue)
    }
    
    func fetchTopRated() async throws -> [Movie] {
        try await fetchMovies(endpoint: MovieEndpoints.topRated.rawValue)
    }
    
    // MARK: - Private
    func fetchMovies(endpoint path: String) async throws -> [Movie] {
        let urlString = "\(baseUrl)\(path)?api_key=\(publicApiKey)"
        // print(urlString)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // TODO: Handle errors? handle request instead of session with url
        let (data, httpResponse) = try await session.data(from: url)
        // print(httpResponse)
        let decodedResponse = try JSONDecoder().decode(MovieListResponse.self, from: data)
        return decodedResponse.results.map { $0.toDomain() }
    }
}

