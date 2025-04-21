//
//  SearchViewModelTests.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 21/04/2025.
//

import XCTest
@testable import TheMovieDbApp

@MainActor
final class SearchViewModelTests: XCTestCase {
    func test_performSearch_withValidQuery_setsMovies() async {
        let mockService = MovieServiceMock()
        mockService.searchResult = [
            SearchResultMovie(
                id: 1,
                title: "asdasdasadsasd",
                posterPath: "/asdasdasadsasd.jpg",
                voteAverage: 8.7,
                releaseDate: "asdasdasadsasd"
            )
        ]
        
        let viewModel = SearchViewModel(service: mockService)
        viewModel.query = "asdasdasadsasd"
        
        await viewModel.performSearch()
        
        XCTAssertTrue(mockService.searchMoviesCalled)
        XCTAssertTrue(viewModel.searchPerformed)
        XCTAssertEqual(viewModel.movies.count, 1)
        XCTAssertEqual(viewModel.movies.first?.title, "asdasdasadsasd")
    }
    
    func test_performSearch_withEmptyQuery_doesNotSearch() async {
        let mockService = MovieServiceMock()
        let viewModel = SearchViewModel(service: mockService)
        viewModel.query = "   "
        
        await viewModel.performSearch()
        
        XCTAssertFalse(mockService.searchMoviesCalled)
        XCTAssertFalse(viewModel.searchPerformed)
        XCTAssertTrue(viewModel.movies.isEmpty)
    }
    
    func test_performSearch_whenServiceThrows_setsEmptyMovies() async {
        let mockService = MovieServiceMock()
        mockService.shouldThrowError = true
        
        let viewModel = SearchViewModel(service: mockService)
        viewModel.query = "asdasdasadsasd"
        
        await viewModel.performSearch()
        
        XCTAssertTrue(mockService.searchMoviesCalled)
        XCTAssertTrue(viewModel.searchPerformed)
        XCTAssertTrue(viewModel.movies.isEmpty)
    }
}
