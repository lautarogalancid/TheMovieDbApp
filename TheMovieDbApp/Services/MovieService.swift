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
    private let cache: MovieCacheProtocol
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let nowPlayingPath = "movie/now_playing"
    
    init(session: URLSession = .shared, cache: MovieCacheProtocol = MovieCache()) {
        self.session = session
        self.cache = cache
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
        let cacheKey = path
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 7
        
        do {
            let (data, response) = try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
                group.addTask {
                    try await self.session.data(for: request)
                }
                group.addTask {
                    try await Task.sleep(for: .seconds(5))
                    throw URLError(.timedOut)
                }
                guard let result = try await group.next() else {
                    throw URLError(.unknown)
                }
                
                group.cancelAll()
                return result
            }
            let decoded = try JSONDecoder().decode(MovieListResponse.self, from: data)
            let movies = decoded.results.map {
                $0.toDomain()
            }
            
            cache.saveMovies(movies, for: cacheKey)
            
            for movie in movies {
                if let url = movie.posterURL,
                   cache.loadImage(for: url.absoluteString) == nil {
                    do {
                        let (imageData, _) = try await session.data(from: url)
                        cache.saveImage(imageData, for: url.absoluteString)
                    } catch {
                        // TODO: Handle errors?
                        continue
                    }
                }
            }
            
            return movies
            
        } catch {
            if let cachedResponse = cache.loadMovies(for: cacheKey) {
                return cachedResponse
            } else {
                throw error
            }
        }
    }
}

