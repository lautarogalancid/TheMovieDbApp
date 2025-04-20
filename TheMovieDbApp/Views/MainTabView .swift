//
//  MainTabView.swift
//  TheMovieDbApp
//
//  Created by Lautaro Emanuel Galan Cid on 19/04/2025.
//

import SwiftUI
import SwiftData

enum AppTab {
    case home
    case search
    case watchlist
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .watchlist: return "Watch List"
        }
    }
    
    var systemImage: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        case .watchlist: return "bookmark"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView(onSearchTap: {
                    selectedTab = .search
                })
            }
            .tabItem {
                Label(AppTab.home.title, systemImage: AppTab.home.systemImage)
            }
            .tag(AppTab.home)
            
            NavigationStack {
                SearchView()
            }
            .tabItem {
                Label(AppTab.search.title, systemImage: AppTab.search.systemImage)
            }
            .tag(AppTab.search)
            
            NavigationStack {
                WatchlistView()
            }
            .tabItem {
                Label(AppTab.watchlist.title, systemImage: AppTab.watchlist.systemImage)
            }
            .tag(AppTab.watchlist)
        }
        .preferredColorScheme(.dark)
        .tint(.blue)
    }
}

#Preview {
    MainTabView()
}

