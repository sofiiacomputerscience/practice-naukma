//
//  Recipe_FinderApp.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 18.06.2023.
//

import SwiftUI

@main
struct Recipe_FinderApp: App {
    // create an instance of the FavouriteRecipesViewModel
    @StateObject private var favouriteRecipesModel = FavouriteRecipesModel()
    @StateObject private var recentRecipesModel = RecentRecipesModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                SearchView()
                    .environmentObject(favouriteRecipesModel)
                    .environmentObject(recentRecipesModel)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                FavouritesView()
                    .environmentObject(favouriteRecipesModel)
                    .environmentObject(recentRecipesModel)
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                RecentView()
                    .environmentObject(favouriteRecipesModel)
                    .environmentObject(recentRecipesModel)
                    .tabItem {
                        Label("Recent", systemImage: "clock")
                    }
            }
            
        }
    }
}


