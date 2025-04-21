//
//  TopMoviePosterView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import SwiftUI

public struct TopMoviePosterView: View {
    let imageUrl: URL?
    let rank: Int
    let height: CGFloat
    let width: CGFloat
    
    private let xOffset = -30.0
    private let yOffset = 50.0
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            // TODO: add custom size capabilities?
            MoviePosterView(imageUrl: imageUrl,
                            height: height, width: width)
            Text("\(rank)")
                .font(.system(size: 96, weight: .bold))
                .foregroundStyle(.white)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .offset(x: xOffset, y: yOffset)
        }
        .frame(width: width-xOffset, height: height+yOffset)
        
    }
}

#Preview {
    TopMoviePosterView(imageUrl: nil, rank: 2, height: 210, width: 140)
}
