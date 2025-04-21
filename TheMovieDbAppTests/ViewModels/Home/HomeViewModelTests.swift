//
//  HomeViewModelTests.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 21/04/2025.
//

import XCTest
@testable import TheMovieDbApp

@MainActor
final class HomeViewModelTests: XCTestCase {
    func test_loadPopularMovies_setsPopularMovies() async {
        let mockService = MovieServiceMock()
        mockService.popularResult = (1...10).map {
            Movie(id: $0, title: "Movie \($0)", posterURL: URL(string: "https://asdasdasdasdas.com/\($0).jpg"))
        }

        let viewModel = HomeViewModel(service: mockService)

        await viewModel.loadPopularMovies()

        XCTAssertTrue(mockService.fetchPopularCalled)
        XCTAssertEqual(viewModel.popularMovies.count, 5)
        XCTAssertEqual(viewModel.popularMovies.first?.title, "Movie 1")
    }

    func test_loadGridMovies_setsNowPlaying() async {
        let mockService = MovieServiceMock()
        mockService.gridResult = (1...10).map {
            Movie(id: $0, title: "asdasdasadsasd \($0)", posterURL: nil)
        }

        let viewModel = HomeViewModel(service: mockService)

        await viewModel.loadGridMovies(for: .nowPlaying)

        XCTAssertTrue(mockService.fetchNowPlayingCalled)
        XCTAssertEqual(viewModel.gridMovies.count, 6)
    }

    func test_selectMovie_fetchesMovieDetails() async {
        let mockService = MovieServiceMock()
        let movie = Movie(id: 1, title: "asdasdasadsasd", posterURL: nil)

        mockService.detailResult = MovieDetail(
            id: 1,
            title: "asdasdasadsasd",
            overview: "asdasdasadsasd",
            posterPath: nil,
            backdropPath: nil,
            releaseDate: "asdasdasadsasd",
            runtime: 120,
            voteAverage: 7.5,
            genres: ["asdasdasadsasd"]
        )

        let viewModel = HomeViewModel(service: mockService)

        await viewModel.selectMovie(movie)

        XCTAssertTrue(mockService.fetchMovieDetailsCalled)
        XCTAssertEqual(viewModel.selectedMovieDetails?.title, "asdasdasadsasd")
    }

    func test_selectMovie_whenError_setsErrorMessage() async {
        let mockService = MovieServiceMock()
        mockService.shouldThrowError = true

        let movie = Movie(id: 99, title: "asdasdasadsasd", posterURL: nil)
        let viewModel = HomeViewModel(service: mockService)

        await viewModel.selectMovie(movie)

        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func test_loadPopularMovies_whenError_setsErrorMessage() async {
        let mockService = MovieServiceMock()
        mockService.shouldThrowError = true
        let viewModel = HomeViewModel(service: mockService)

        await viewModel.loadPopularMovies()

        XCTAssertTrue(mockService.fetchPopularCalled)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.popularMovies.isEmpty)
    }

    func test_loadGridMovies_upcoming_setsGridMovies() async {
        let mockService = MovieServiceMock()
        mockService.gridResult = (1...10).map {
            Movie(id: $0, title: "asdasdasadsasd \($0)", posterURL: nil)
        }
        let viewModel = HomeViewModel(service: mockService)

        await viewModel.loadGridMovies(for: .upcoming)

        XCTAssertTrue(mockService.fetchUpcomingCalled)
        XCTAssertEqual(viewModel.gridMovies.count, 6)
    }

    func test_loadGridMovies_topRated_setsGridMovies() async {
        let mockService = MovieServiceMock()
        mockService.gridResult = (1...10).map {
            Movie(id: $0, title: "asdasdasadsasd \($0)", posterURL: nil)
        }
        let viewModel = HomeViewModel(service: mockService)

        await viewModel.loadGridMovies(for: .topRated)

        XCTAssertTrue(mockService.fetchTopRatedCalled)
        XCTAssertEqual(viewModel.gridMovies.count, 6)
    }

    func test_loadGridMovies_whenError_setsErrorMessage() async {
        let mockService = MovieServiceMock()
        mockService.shouldThrowError = true
        let viewModel = HomeViewModel(service: mockService)

        await viewModel.loadGridMovies(for: .nowPlaying)

        XCTAssertTrue(mockService.fetchNowPlayingCalled)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.gridMovies.isEmpty)
    }
}
