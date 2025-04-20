//
//  HomeView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 19/04/2025.
//

import SwiftUICore
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State var selectedCategory: Categories = .nowPlaying
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 3)
    let onSearchTap: () -> Void
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading,
                   spacing: 16) {
                Text("What do you want to watch?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.top)
                Button(action: onSearchTap) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        Text("Search")
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                // TODO: Mover a view propia?
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Array(viewModel.popularMovies.enumerated()), id: \.1.id) { index, movie in
                            TopMoviePosterView(imageUrl: movie.posterURL, rank: index + 1, height: 210, width: 140)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 250)
                CategoriesTabView(selected: $selectedCategory)
                // TODO: Mover a view propia?
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.gridMovies) { movie in
                        MoviePosterView(imageUrl: movie.posterURL, height: 145, width: 100)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
                   .task {
                       await viewModel.loadPopularMovies()
                       await viewModel.loadGridMovies(for: selectedCategory)
                   }
                   .onChange(of: selectedCategory) {
                       Task {
                           await viewModel.loadGridMovies(for: selectedCategory)
                       }
                   }
        }
        .padding(.bottom)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(), onSearchTap: {
        // nada
    }).preferredColorScheme(.dark)
}
