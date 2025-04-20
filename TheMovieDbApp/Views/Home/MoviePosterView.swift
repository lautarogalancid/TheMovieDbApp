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
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.green) // TODO: placeholder, show img
            .frame(width: width, height: height)
    }
}

#Preview {
    MoviePosterView(imageUrl: nil, height: 210, width: 140)
}
