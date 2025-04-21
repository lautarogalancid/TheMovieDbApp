//
//  MovieDetailDTO.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import Foundation

struct MovieDetailDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let runtime: Int?
    let voteAverage: Double
    let genres: [GenreDTO]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
        case genres
    }
    
    func toDomain() -> MovieDetail {
        MovieDetail(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate,
            runtime: runtime,
            voteAverage: voteAverage,
            genres: genres.map(\.name)
        )
    }
}
