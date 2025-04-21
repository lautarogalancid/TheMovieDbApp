//
//  SearchMovieDTO.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 21/04/2025.
//

struct SearchResponse: Decodable {
    let results: [SearchMovieDTO]
}

struct SearchMovieDTO: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }

    func toDomain() -> SearchResultMovie {
        SearchResultMovie(
            id: id,
            title: title,
            posterPath: posterPath,
            voteAverage: voteAverage,
            releaseDate: releaseDate
        )
    }
}
