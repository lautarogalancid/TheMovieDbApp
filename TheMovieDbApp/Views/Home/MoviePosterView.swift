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
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in image
                .resizable()
                .scaledToFill()
        } placeholder: {
            // TODO: Add static image
            Color.purple
        }.clipped()
            .frame(width: width, height: height)
    }
}

#Preview {
    MoviePosterView(imageUrl: nil, height: 210, width: 140)
}
