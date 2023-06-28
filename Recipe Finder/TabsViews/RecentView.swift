//
//  RecentView.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 18.06.2023.
//

import SwiftUI

struct RecentView: View {
    @EnvironmentObject var recentRecipesModel: RecentRecipesModel
    @EnvironmentObject var favouriteRecipesModel: FavouriteRecipesModel
    @State private var selectedRecipeModel: RecipeModel?
    @State private var sortOrder: SortOrder = .ascending
    @State private var sortBy: SortBy = .addedtime
    @State private var showSortMenu = false
    @State private var sortedRecipes: [RecipeModel] = []
    @State private var sortType: String = "Added Time"

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(sortedRecipes.indices, id: \.self) { index in
                        NavigationLink(
                            destination: RecipeDetailsView(
                                recipeModel: $sortedRecipes[index],
                                isLiked: sortedRecipes[index].isLiked
                            ).environmentObject(favouriteRecipesModel),
                            tag: sortedRecipes[index],
                            selection: $selectedRecipeModel,
                            label: {
                                RecipeCellView(
                                    recipeModel: $sortedRecipes[index]
                                )
                            }
                        )
                        .onTapGesture {
                            self.selectedRecipeModel = sortedRecipes[index]
                        }
                    }
                }
            }
            .navigationTitle("Recent")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    showSortMenu.toggle()
                }) {
                    VStack {
                        Image(systemName: "arrow.up.arrow.down.circle")
                        Text("Sort by:")
                            .font(.footnote)
                        Text(sortType)
                            .font(.footnote)
                    }
                }
                .actionSheet(isPresented: $showSortMenu) {
                    ActionSheet(
                        title: Text("Sort Recipes By:"),
                        buttons: SortBy.allCases.map { sortCase in
                            .default(Text(sortCase.userFriendlyName)) {
                                self.sortBy = sortCase
                                self.sortType = sortCase.userFriendlyName
                                sortRecipes()
                            }
                        } + [.cancel()]
                    )
                }
                Button(action: {
                    sortOrder = sortOrder == .ascending ? .descending : .ascending
                    sortRecipes()
                }) {
                    VStack {
                        Image(systemName: sortOrder == .ascending ? "arrow.up" : "arrow.down")
                        Text(labelForSortOrder)
                            .font(.footnote)
                    }
                }
            })
            .onAppear {
                recentRecipesModel.delete()
                for index in recentRecipesModel.recipes.indices {
                    if favouriteRecipesModel.recipes.contains(where: { $0.id == recentRecipesModel.recipes[index].id }) {
                        recentRecipesModel.recipes[index].isLiked = true
                    } else {
                        recentRecipesModel.recipes[index].isLiked = false
                    }
                }
                sortRecipes()
            }
        }
    }

    func sortRecipes() {
        switch sortBy {
            case .addedtime:
                sortedRecipes = sortOrder == .ascending
                ? recentRecipesModel.recipes
                : recentRecipesModel.recipes.reversed()
            case .name:
                sortedRecipes = sortOrder == .ascending
                ? recentRecipesModel.recipes.sorted { $0.recipe.label < $1.recipe.label }
                : recentRecipesModel.recipes.sorted { $0.recipe.label > $1.recipe.label }
            case .cookingtime:
                sortedRecipes = sortOrder == .ascending
                ? recentRecipesModel.recipes.sorted { $0.recipe.totalTime ?? 0 < $1.recipe.totalTime ?? 0 }
                : recentRecipesModel.recipes.sorted { $0.recipe.totalTime ?? 0 > $1.recipe.totalTime ?? 0 }
            case .fat:
                sortedRecipes = sortOrder == .ascending
                ? recentRecipesModel.recipes.sorted { $0.recipe.totalNutrients.fat.quantity < $1.recipe.totalNutrients.fat.quantity }
                : recentRecipesModel.recipes.sorted { $0.recipe.totalNutrients.fat.quantity > $1.recipe.totalNutrients.fat.quantity }
            case .carbs:
                sortedRecipes = sortOrder == .ascending
                ? recentRecipesModel.recipes.sorted { $0.recipe.totalNutrients.carbs.quantity < $1.recipe.totalNutrients.carbs.quantity }
                : recentRecipesModel.recipes.sorted { $0.recipe.totalNutrients.carbs.quantity > $1.recipe.totalNutrients.carbs.quantity }
            case .protein:
                sortedRecipes = sortOrder == .ascending
                ? recentRecipesModel.recipes.sorted { $0.recipe.totalNutrients.protein.quantity < $1.recipe.totalNutrients.protein.quantity }
                : recentRecipesModel.recipes.sorted { $0.recipe.totalNutrients.protein.quantity > $1.recipe.totalNutrients.protein.quantity }
            case .calories:
                sortedRecipes = recentRecipesModel.recipes.sorted { (lhs, rhs) in
                    let lhsCaloriesPerYield = (lhs.recipe.calories ?? 0) / (lhs.recipe.yield ?? 0)
                    let rhsCaloriesPerYield = (rhs.recipe.calories ?? 0) / (rhs.recipe.yield ?? 0)
                    return sortOrder == .ascending ? lhsCaloriesPerYield < rhsCaloriesPerYield : lhsCaloriesPerYield > rhsCaloriesPerYield
                }
                
        }
    }
    
    var labelForSortOrder: String {
        switch (sortOrder, sortBy) {
            case (.ascending, .name):
                return "A-Z"
            case (.descending, .name):
                return "Z-A"
            case (.ascending, .cookingtime):
                return "Shortest"
            case (.descending, .cookingtime):
                return "Longest"
            case (.ascending, .addedtime):
                return "Newest"
            case (.descending, .addedtime):
                return "Oldest"
            case (.ascending, _):
                return "Most"
            case (.descending, _):
                return "Least"
        }
    }

}



struct RecentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentView()
            .environmentObject(RecentRecipesModel())
            .environmentObject(FavouriteRecipesModel())
    }
}
