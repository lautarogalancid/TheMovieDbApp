//
//  MovieDetailView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//
import SwiftUI

struct MovieDetailView: View {
    let movie: MovieDetail

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                BackdropWithScoreView(
                    backdropURL: movie.backdropURL,
                    voteAverage: movie.voteAverage,
                    height: 210
                )

                VStack(alignment: .leading, spacing: 8) {
                    PosterAndTitleDetailView(
                        posterURL: movie.posterURL,
                        title: movie.title
                    )
                }
                .offset(y: 50)
            }
            .padding(.bottom, 50)
            .padding(.vertical)

            VStack(alignment: .center, spacing: 16) {
                // TODO: Move into own view
                HStack(spacing: 8) {
                    Label(movie.releaseDate.prefix(4), systemImage: "calendar")
                    Text("|")
                    Label("\(movie.runtime ?? 0) min", systemImage: "clock")
                    Text("|")
                    Label(movie.genres.joined(separator: ", "), systemImage: "ticket")
                }
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.overview)
                        .font(.body)
                }
                .padding(.horizontal)
            }
            //.padding(.top)
        }
        .background(Color.black)
        .foregroundColor(.white)
    }
}

#Preview {
    MovieDetailView(movie: MovieDetail(
        id: 1,
        title: "Finding Nemo: Final Adventures DVD Whatever",
        overview: "Nemo, an adventurous young clownfish, is unexpectedly taken...",
        posterPath: "/eHuGQ10FUzK1mdOY69wF5pGgEf5.jpg",
        backdropPath: "/eCynaAOgYYiw5yN5lBwz3IxqvaW.jpg",
        releaseDate: "2003-05-30",
        runtime: 100,
        voteAverage: 7.8,
        genres: ["Animation", "Family"]
    ))
}
