//
//  MovieCache.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import Foundation

protocol MovieCacheProtocol {
    func saveMovies(_ movies: [Movie], for endpoint: String)
    func loadMovies(for endpoint: String) -> [Movie]?
    func saveImage(_ data: Data, for key: String)
    func loadImage(for key: String) -> Data?
}

class MovieCache: MovieCacheProtocol {
    private let fileManager: FileManager
    private let memoryCache = NSCache<NSString, NSData>()
    private let cacheDirectory: URL?
    
    init (fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.cacheDirectory = try? fileManager.url(for: .cachesDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: true)
    }
    
    func saveMovies(_ movies: [Movie], for endpoint: String) {
        guard let directory = cacheDirectory else { return }
        let fileURL = directory.appendingPathComponent("\(endpoint).json")

        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: fileURL)
        } catch {
            // TODO: Handle error
        }
    }

    func loadMovies(for endpoint: String) -> [Movie]? {
        guard let directory = cacheDirectory else { return nil }
        let fileURL = directory.appendingPathComponent("\(endpoint).json")
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode([Movie].self, from: data)
    }

    func saveImage(_ data: Data, for key: String) {
        memoryCache.setObject(data as NSData, forKey: key as NSString)
        guard let fileURL = fileURL(for: key) else { return }
        try? data.write(to: fileURL)
    }

    func loadImage(for key: String) -> Data? {
        if let data = memoryCache.object(forKey: key as NSString) {
            return data as Data
        }
        guard let fileURL = fileURL(for: key), let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        memoryCache.setObject(data as NSData, forKey: key as NSString)
        return data
    }

    // MARK: - Private
    private func fileURL(for key: String) -> URL? {
        cacheDirectory?.appendingPathComponent("\(key).cache")
    }
}
