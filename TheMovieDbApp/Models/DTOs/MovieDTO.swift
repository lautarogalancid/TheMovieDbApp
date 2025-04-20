//
//  MovieDTO.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import Foundation

struct MovieListResponse: Decodable {
    let results: [MovieDTO]
}

struct MovieDTO: Decodable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

extension MovieDTO {
    func toDomain() -> Movie {
        Movie(id: id,
              title: title,
              posterURL: posterPath.flatMap { URL(string: "https://image.tmdb.org/t/p/w500\($0)")} )
    }
}

