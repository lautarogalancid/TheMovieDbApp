//
//  SearchView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 19/04/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $viewModel.query)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        Task {
                            await viewModel.performSearch()
                        }
                    }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .padding()

            if viewModel.movies.isEmpty && viewModel.searchPerformed {
                SearchEmptyStateView()
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.movies) { movie in
                            SearchResultRowView(
                                title: movie.title,
                                posterURL: movie.posterURL,
                                voteAverage: movie.voteAverage,
                                releaseYear: movie.releaseYear
                            )
                            .padding(.horizontal)
                        }
                        // TODO: Spinner / load more indicator?
                    }
                }
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: Add info
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .preferredColorScheme(.dark)
        .tint(.blue)
}
