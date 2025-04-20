//
//  Movie.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import Foundation

struct Movie: Identifiable {
    let id: Int
    let title: String
    let posterURL: URL?
}
