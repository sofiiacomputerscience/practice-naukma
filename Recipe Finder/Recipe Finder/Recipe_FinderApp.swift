//
//  Recipe_FinderApp.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 18.06.2023.
//

import SwiftUI

@main
struct Recipe_FinderApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                FavouritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                RecentView()
                    .tabItem {
                        Label("Recent", systemImage: "clock")
                    }
            }
            
        }
    }
}
