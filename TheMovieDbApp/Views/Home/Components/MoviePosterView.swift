//
//  MoviePosterView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//
import SwiftUI

struct MoviePosterView: View {
    let imageUrl: URL?
    let height: CGFloat
    let width: CGFloat
    let cache: MovieCacheProtocol
    
    init(imageUrl: URL?,
         height: CGFloat,
         width: CGFloat,
         cache: MovieCacheProtocol = MovieCache()) {
        self.imageUrl = imageUrl
        self.height = height
        self.width = width
        self.cache = cache
    }
    
    var body: some View {
        if let url = imageUrl,
           let data = cache.loadImage(for: url.absoluteString),
           let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
        } else {
            // TODO: Remove img download, receive img downloaded alread
            AsyncImage(url: imageUrl) { status in
                switch status {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                default:
                    Color.purple // TODO: Add placeholder asset img?
                }
            }
        }
    }
}
