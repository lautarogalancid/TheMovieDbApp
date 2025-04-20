//
//  HomeView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 19/04/2025.
//

import SwiftUICore
import SwiftUI

struct HomeView: View {
    let onSearchTap: () -> Void
    @State var selectedCategory: CategoriesTab = .nowPlaying
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 3)
    
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
                // TODO: Mover a view propia
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(1...5, id: \.self) { rank in
                            TopMoviePosterView(imageUrl: nil, rank: rank, height: 210, width: 140)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 250)
                CategoriesTabView(selected: $selectedCategory)
                // TODO: Mover a view propia
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<6) { _ in
                        MoviePosterView(imageUrl: nil, height: 145, width: 100)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    HomeView(onSearchTap: {
        // nada
    }).preferredColorScheme(.dark)
}
