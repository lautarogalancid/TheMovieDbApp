//
//  CategoriesTabView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 20/04/2025.
//

import SwiftUI
import SwiftUICore

enum Categories: String, CaseIterable, Identifiable {
    case nowPlaying = "Now Playing"
    case upcoming = "Upcoming"
    case topRated = "Top Rated"
    var id: String { self.rawValue }
}

struct CategoriesTabView: View {
    @Binding var selected: Categories
    var body: some View {
        HStack {
            ForEach(Categories.allCases) { tab in
                Button(action: {
                    selected = tab
                }) {
                    VStack {
                        Text(tab.rawValue)
                            .font(.subheadline)
                            .fontWeight(selected == tab ? .bold : .regular)
                            .foregroundStyle(.white)
                        
                        Rectangle()
                            .fill(selected == tab ? Color.blue : .clear)
                            .frame(height: 3)
                            .padding(.top, 4)
                        
                    }
                }
                //.frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
}
