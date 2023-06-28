//
//  DetailsView.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 18.06.2023.
//

import SwiftUI

struct FoundedRecipesView: View {
    @EnvironmentObject var favouriteRecipesModel: FavouriteRecipesModel
    @EnvironmentObject var recentRecipesModel: RecentRecipesModel
    @State var recipeModels: [RecipeModel]
    @State private var selectedRecipeModel: RecipeModel?
    
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(recipeModels.indices, id: \.self) { index in
                    NavigationLink(
                        destination: RecipeDetailsView(recipeModel: $recipeModels[index], isLiked: recipeModels[index].isLiked).environmentObject(favouriteRecipesModel).environmentObject(recentRecipesModel),
                        tag: recipeModels[index],
                        selection: $selectedRecipeModel,
                        label: {
                            RecipeCellView(recipeModel: $recipeModels[index])
                        })
                    .onTapGesture {
                        self.selectedRecipeModel = recipeModels[index]
                    }
                }
            }
        }
        .onAppear {
            for index in recipeModels.indices {
                if favouriteRecipesModel.recipes.contains(where: { $0.id == recipeModels[index].id }) {
                    recipeModels[index].isLiked = true
                } else {
                    recipeModels[index].isLiked = false
                }
            }
        }
    }
}

struct FoundedRecipesView_Previews: PreviewProvider {
    static var previews: some View {
            let recipe = Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_16f636c6ef7f82621fa9bc1ab08c1c96",
                                label: "Sushi rolls",
                                image: "https://edamam-product-images.s3.amazonaws.com/web-img/524/524b1355041d6a6c74d0481d7b50882a-s.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjECIaCXVzLWVhc3QtMSJIMEYCIQD5Kp5O8ODINRI0Rz0nr0TVJ%2FO0E0MPrK1czfLE6HO1jgIhAJ5D4RfZAgCf1NevWUgHeCVPk%2B8yIRIr8X0N5Y5sssn1KrkFCHsQABoMMTg3MDE3MTUwOTg2IgzCsWWwxE7XYLL7e8YqlgWb8GGU3ZQeLIS3%2FwNdKmc7FdKADAmH0%2Bt1uHy1sEr7DYS2ZzMHh9czeLisKKN7J900wvfc9pylcwftvOpt%2FIPsa9O3qbtaJeLuf1%2FXRFGq1NDHfKkW9beNyiQZgqHyU4Rw1%2FuPlb0FXTzkbBLzlq5vic1%2F31WBY7tBOoBBZI0J%2BFJgYb8xwZ06cWSzb7Yu6MdFbQCQch5CrU0X60s9oN9cSF4XmX2%2Bpv5NSQqeeD9eLTEgdz%2FmtHLAJ1Y8t7o%2FViOD%2FLmuCVaeaNMT8JNwHawlXVbAeiLyUQR5EHxXUFbDk01JhpgPwTP9nHjsJ%2FevjzQK3OgRAS9smqBVu4a%2BKW9GvpfrTHF1dGeLqKikUIbX3YRXEQb6%2B8gdRzpRHzRksQTLNJNU5dlZGpzZj6nv7DAV5eKsr6%2FBXu8j2yHwb9FDJuUv3EvdRSlfJnqYKhm9aBUISwprFhneOoBJLTLFMf7DglM7QuLP%2FcCiYy%2FGJJNEosTR3oOP4iWVpR1C2UP2Yxx7GQcZK1PGrzHPQap5pf%2ByzJ1oFBhAig8I7xC%2B4CZTAmDNWiOor1pNFs5yPRPb3OLBaPOoU8EopHBkVy8Pf169yqhTyohHNspOjnUhiN%2F6KpBE4cyjsHMWEjXg6Q%2FoSDNvA%2FAVKXAJvSDtusjKSJXYRQqV6yfe0NwnQ9HWDNI19nHh8RUGZOo6a3plLo4XDkHKCeTN5kGU9uyvAcYElnt0colMqyiJpw4FXliR80k1JxeYIoEWBpScvvaCl%2BBm%2B01OUpXXXgBHIJbSTk6fkLZGl99vV9lE%2F%2BiEs7wc9Xf04B5gACsK9kaW%2FmMczGQhl8ZTbyUo%2BQdXKe01C7KAyvC9elgmSXJBL%2B0Ndo5fO8VejciLoaa6iTDWgr2kBjqwAfS%2B3ZY%2BrwMG2CtZhvCzauvHaL5TowY3RodvymHPwp1rWAL0j3%2F7T7uxqNYNIeCvnFpA4niBkvTIlL%2BMHg4AfTNJj28JhuTYcRLk39%2B7veg7Cid2bmBxGPVk2yX2cspumiXfWP8jVDCHO4YLSYUSbxIdnPT2GsQLqUrmZn%2FHp8G5yGQaGZf%2FV6fHkzpsHGboCabkdgfOYftBdx0HxjUpDv9qXlkOiL6WrZ%2F2fkfp1IZj&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230618T180151Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFJWCCQ35P%2F20230618%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=136ecc3b47b9a86c00f5e4ce0dc45f21694b3a1111619fec74ac1b731b636ae5",
                                source: "Jamie Oliver",
                                url:"http://www.jamieoliver.com/recipes/rice-recipes/sushi-rolls/",
                                yield: 3,
                                dietLabels: [
                                    "Low-Fat",
                                    "Low-Sodium"
                                ],
                                healthLabels: [
                                    "Sugar-Conscious",
                                    "Vegan",
                                    "Vegetarian",
                                    "Pescatarian",
                                    "Mediterranean",
                                    "DASH",
                                    "Dairy-Free",
                                    "Gluten-Free",
                                    "Wheat-Free",
                                    "Egg-Free",
                                    "Peanut-Free",
                                    "Tree-Nut-Free",
                                    "Soy-Free",
                                    "Fish-Free",
                                    "Shellfish-Free",
                                    "Pork-Free",
                                    "Red-Meat-Free",
                                    "Crustacean-Free",
                                    "Celery-Free",
                                    "Mustard-Free",
                                    "Sesame-Free",
                                    "Lupine-Free",
                                    "Mollusk-Free",
                                    "Alcohol-Free",
                                    "No oil added",
                                    "Sulfite-Free",
                                    "Kosher"
                                ],
                                ingredients: [],
                                calories: 878.1170000000001,
                                totalWeight: 430.975,
                                totalTime: 50,
                                cuisineType: [
                                    "japanese"
                                ],
                                mealType: [
                                    "lunch/dinner"
                                ],
                                dishType: [
                                    "main course"
                                ],
                                totalNutrients: AllNutrients(
                                    energy: Nutrient(label: "energy", quantity: 878.117, unit: "kcal"),
                                    fat: Nutrient(label: "fat", quantity: 12.46976, unit: "g"),
                                    carbs: Nutrient(label: "carbs", quantity: 172.82856749999996, unit: "g"),
                                    protein: Nutrient(label: "protein", quantity: 16.09692, unit: "g")),
                                totalDaily: AllNutrients(
                                    energy: Nutrient(label: "energy", quantity: 878.117, unit: "kcal"),
                                    fat: Nutrient(label: "fat", quantity: 12.46976, unit: "g"),
                                    carbs: Nutrient(label: "carbs", quantity: 172.82856749999996, unit: "g"),
                                    protein: Nutrient(label: "protein", quantity: 16.09692, unit: "g")))
        FoundedRecipesView(recipeModels: Array(repeating: RecipeModel(recipe: recipe, isLiked: false), count: 20))
            .environmentObject(FavouriteRecipesModel())
            .environmentObject(RecentRecipesModel())
    }
}

