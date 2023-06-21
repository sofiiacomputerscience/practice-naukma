//
//  DetailsView.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 18.06.2023.
//

import SwiftUI

struct FoundedRecipesView: View {
    
    var recipes : [Recipe]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(recipes) { recipe in
                        NavigationLink(value: recipe){
                            RecipeCellView(recipe: recipe)
                        }
                    }
                }
            }.navigationDestination(for: Recipe.self) {
                recipe in
                RecipeDetailsView(recipe: recipe)
            }
        }
    }
}

struct FoundedRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        FoundedRecipesView(recipes: [])
    }
}
