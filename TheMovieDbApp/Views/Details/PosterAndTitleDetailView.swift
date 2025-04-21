//
//  PosterAndTitleDetailView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import SwiftUI

struct PosterAndTitleDetailView: View {
    let posterURL: URL?
    let title: String
    let width: CGFloat = 95
    let height: CGFloat = 120

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            // TODO: Remove img download, receive img
            AsyncImage(url: posterURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Color.gray
                }
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(2)

            Spacer()
        }
    }
}

#Preview {
    PosterAndTitleDetailView(
        posterURL: URL(string: "https://image.tmdb.org/t/p/w500/eHuGQ10FUzK1mdOY69wF5pGgEf5.jpg"),
        title: "Buscando a Nemo"
    )
    .preferredColorScheme(.dark)
}
