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
    // SMELL: Interface segregation? Maybe split service into service per view (home, search, detail) if it grows too much.
    func fetchMovieDetails(id: Int) async throws -> MovieDetail
    func searchMovies(query: String, page: Int) async throws -> [SearchResultMovie]
}

enum MovieEndpoints: String {
    case popular = "movie/popular"
    case nowPlaying = "movie/now_playing"
    case upcoming = "movie/upcoming"
    case topRated = "movie/top_rated"
    case details = "movie"
    case search = "search/movie"
}

class MovieService: MovieServiceProtocol {
    private let publicApiKey = "1fec327a16dfa43c4d0c3c78cd7d8c4d" // TODO: Define better placement for api key
    private let session: URLSession
    private let cache: MovieCacheProtocol
    private let baseUrl = "https://api.themoviedb.org/3/"
    
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
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        let urlString = "\(baseUrl)\(MovieEndpoints.details.rawValue)/\(id)?api_key=\(publicApiKey)"
    
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        do {
            let data = try await fetchData(from: url)
            let dto = try JSONDecoder().decode(MovieDetailDTO.self, from: data)
            return dto.toDomain()
        } catch {
            throw error // TODO: Handle error? add cache to this? Makes sense?
        }
    }
    
    func searchMovies(query: String, page: Int = 1) async throws -> [SearchResultMovie] {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw URLError(.badURL)
        }
        
        let urlString = "\(baseUrl)\(MovieEndpoints.search.rawValue)?api_key=\(publicApiKey)&query=\(encodedQuery)&page=\(page)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let data = try await fetchData(from: url)
        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
        return decoded.results.map { $0.toDomain() }
    }

    // MARK: - Private
    private func fetchMovies(endpoint path: String) async throws -> [Movie] {
        let urlString = "\(baseUrl)\(path)?api_key=\(publicApiKey)"
        let cacheKey = path

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        do {
            let data = try await fetchData(from: url)
            let decoded = try JSONDecoder().decode(MovieListResponse.self, from: data)
            let movies = decoded.results.map { $0.toDomain() }

            cache.saveMovies(movies, for: cacheKey)

            for movie in movies {
                if let url = movie.posterURL,
                   cache.loadImage(for: url.absoluteString) == nil {
                    do {
                        let (imageData, _) = try await session.data(from: url)
                        cache.saveImage(imageData, for: url.absoluteString)
                    } catch {
                        continue
                    }
                }
            }

            return movies

        } catch {
            if let cached = cache.loadMovies(for: cacheKey) {
                return cached
            } else {
                throw error
            }
        }
    }

    private func fetchData(from url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.timeoutInterval = 7
        
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
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}

