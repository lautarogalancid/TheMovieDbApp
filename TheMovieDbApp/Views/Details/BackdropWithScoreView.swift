//
//  BackdropWithScoreView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import SwiftUI

struct BackdropWithScoreView: View {
    let backdropURL: URL?
    let voteAverage: Double
    let height: CGFloat

    var body: some View {
        ZStack {
            AsyncImage(url: backdropURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Color.gray
                }
            }
            .frame(height: height)
            .clipped()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // TODO: add video player
                    }) {
                        Image(systemName: "play")
                            .resizable()
                            .frame(width: 65, height: 65)
                            .foregroundStyle(.white)
                            .shadow(radius: 10)
                            .opacity(0.8)
                    }
                    Spacer()
                }
                Spacer()
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text(String(format: "%.1f", voteAverage))
                            .foregroundStyle(.yellow)
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .padding()
                }
            }
        }
        .frame(height: height)
    }
}

#Preview {
    BackdropWithScoreView(
        backdropURL: URL(string: "https://image.tmdb.org/t/p/w780/eCynaAOgYYiw5yN5lBwz3IxqvaW.jpg"),
        voteAverage: 7.8,
        height: 210
    )
    .preferredColorScheme(.dark)
}
