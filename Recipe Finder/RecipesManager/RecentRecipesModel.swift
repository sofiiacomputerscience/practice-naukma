//
//  RecentRecipesModel.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 25.06.2023.
//

import Foundation

class RecentRecipesModel: ObservableObject {
    @Published var recipes: [RecipeModel]

    init() {
        self.recipes = loadRecentRecipesFromDisk()
    }

    func load(recipe: RecipeModel) {
        if !self.recipes.contains(where: {$0.recipe.id == recipe.recipe.id}) {
            self.recipes.insert(recipe, at: 0)
            saveRecentRecipeToDisk(recipe)
        }
    }

    func delete() {
        if self.recipes.count > 20 {
            self.recipes.removeLast()
            deleteRecentRecipeFromDisk()
        }
    }
}
