//
//  FavouriteRecipesViewModel.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 24.06.2023.
//

import Foundation

class FavouriteRecipesModel: ObservableObject {
    @Published var recipes: [RecipeModel]

    init() {
        self.recipes = loadLikedRecipesFromDisk()
    }

    func like(recipe: RecipeModel) {
        if !self.recipes.contains(where: {$0.recipe == recipe.recipe}) {
            var newRecipe = recipe
            newRecipe.isLiked = true
            self.recipes.append(newRecipe)
            saveLikedRecipeToDisk(newRecipe)
        }
    }

    func dislike(recipe: RecipeModel) {
        if let index = self.recipes.firstIndex(where: {$0.recipe == recipe.recipe}) {
            var recipeToUpdate = self.recipes[index]
            recipeToUpdate.isLiked = false
            deleteLikedRecipeFromDisk(recipeToUpdate)
            self.recipes.remove(at: index)
        }
    }
}

