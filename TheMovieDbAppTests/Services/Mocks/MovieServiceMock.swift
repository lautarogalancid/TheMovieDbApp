//
//  MovieServiceMock.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 21/04/2025.
//

@testable import TheMovieDbApp
import Foundation

final class MovieServiceMock: MovieServiceProtocol {
    var fetchPopularCalled = false
    var fetchNowPlayingCalled = false
    var fetchUpcomingCalled = false
    var fetchTopRatedCalled = false
    var fetchMovieDetailsCalled = false
    var searchMoviesCalled = false

    var popularResult: [Movie] = []
    var gridResult: [Movie] = []
    var detailResult: MovieDetail?
    var searchResult: [SearchResultMovie] = []

    var shouldThrowError = false

    func fetchPopular() async throws -> [Movie] {
        fetchPopularCalled = true
        if shouldThrowError { throw URLError(.badServerResponse) }
        return popularResult
    }

    func fetchNowPlaying() async throws -> [Movie] {
        fetchNowPlayingCalled = true
        if shouldThrowError { throw URLError(.badServerResponse) }
        return gridResult
    }

    func fetchUpcoming() async throws -> [Movie] {
        fetchUpcomingCalled = true
        if shouldThrowError { throw URLError(.badServerResponse) }
        return gridResult
    }

    func fetchTopRated() async throws -> [Movie] {
        fetchTopRatedCalled = true
        if shouldThrowError { throw URLError(.badServerResponse) }
        return gridResult
    }

    func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        fetchMovieDetailsCalled = true
        if shouldThrowError || detailResult == nil {
            throw URLError(.badServerResponse)
        }
        return detailResult!
    }

    func searchMovies(query: String, page: Int) async throws -> [SearchResultMovie] {
        searchMoviesCalled = true
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return searchResult
    }
}
