//
//  ContentView.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 18.06.2023.
//

import SwiftUI

private enum ButtonPosition {
    case left, right
}

struct SearchView: View {
    
    @State private var searchLabel = "Search recipe by name"
    @State private var searchString = ""
    @State private var isNavigationLinkActive = false
    @State private var isLoading = false
    @StateObject var recipesModel = RecipesModel()
    @State private var recipeModels: [RecipeModel] = []
    @FocusState private var isInputActive: Bool
    @EnvironmentObject var favouriteRecipesModel: FavouriteRecipesModel
    @EnvironmentObject var recentRecipesModel: RecentRecipesModel

    
    func performSearch() {
        isLoading = true
        print("Searching \(searchString)...")
        self.recipesModel.loadRecipes(query: searchString) {
            self.recipeModels = self.recipesModel.recipes.map { recipe in
                let isLiked = favouriteRecipesModel.recipes.contains(where: { $0.id == recipe.id })
                return RecipeModel(recipe: recipe, isLiked: isLiked)
            }
            self.isNavigationLinkActive = true
            self.isLoading = false
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        Text(searchLabel)
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.searchLabelColor)
                            .padding(.horizontal, 16)
                            .padding(.top, 25)
                            .padding(.bottom, 10)
                        
                        HStack(spacing: 18) {
                            Image(systemName: "magnifyingglass")
                                .accessibilityIdentifier("magnifyingglass")
                                .frame(width: 15, height: 15)
                                .foregroundColor(.black)
                            TextField(
                                "",
                                text: $searchString,
                                onCommit: {
                                    performSearch()
                                }
                            )
                            .foregroundColor(.black)
                            .focused($isInputActive)
                            NavigationLink(
                                destination: FoundedRecipesView(recipeModels: recipeModels).environmentObject(favouriteRecipesModel).environmentObject(recentRecipesModel),
                                isActive: $isNavigationLinkActive,
                                label: { EmptyView() })
                            Button(action: {
                                searchString = ""
                                isInputActive = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15))
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 18)
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 16)
                        //.accessibilityIdentifier("xmark.circle.fill")
                        
                        Text("Popular")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.top, 25)
                            .padding(.bottom, 20)
                        
                        createHorizontalButtonGroup(foodImageLeft: "pizzaImage", titleTextLeft: "Pizza", foodImageRight: "sandwichImage", titleTextRight: "Sandwiches")
                        
                        createHorizontalButtonGroup(foodImageLeft: "soupImage", titleTextLeft: "Soups", foodImageRight: "pastaImage", titleTextRight: "Pasta")
                        
                        createHorizontalButtonGroup(foodImageLeft: "asianImage", titleTextLeft: "Asian", foodImageRight: "seafoodImage", titleTextRight: "Seafood")
                        
                        createHorizontalButtonGroup(foodImageLeft: "saladImage", titleTextLeft: "Salad", foodImageRight: "dessertsImage", titleTextRight: "Desserts")
                        
                        createHorizontalButtonGroup(foodImageLeft: "vegetarianImage", titleTextLeft: "Vegetarian", foodImageRight: "drinksImage", titleTextRight: "Drinks")
                        
                        createHorizontalButtonGroup(foodImageLeft: "alcoholcocktailsImage", titleTextLeft: "Cocktails", foodImageRight: "breakfastImage", titleTextRight: "Breakfast")
                        
                        
                        
                        Spacer()
                    }
                    
                }
                
                if isLoading {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView()
                        .scaleEffect(2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundLightColor)
        }
        .navigationViewStyle(.stack)
    }
    
    
    
    @ViewBuilder
    private func createSearchPopularRecipesButton(foodImage: Image, titleText: String, buttonPosition : ButtonPosition) -> some View {
        Button {
            isLoading = true
            print("Button \(titleText) is Tapped")
            recipesModel.loadRecipes(query: titleText){
                self.recipeModels = self.recipesModel.recipes.map { recipe in
                    let isLiked = favouriteRecipesModel.recipes.contains(where: { $0.id == recipe.id })
                    return RecipeModel(recipe: recipe, isLiked: isLiked)
                }
                self.isNavigationLinkActive = true
                self.isLoading = false
            }
        } label: {
            HStack(spacing: 10) {
                Text(titleText)
                    .font(.subheadline)
                    .foregroundColor(Color.buttonTextColor)
                    .frame(width: 86.5)
                foodImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .cornerRadius(15)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.white)
        .cornerRadius(15)
        .padding(buttonPosition == .left ? .leading : .trailing, 16)
        
    }
    
    @ViewBuilder
    private func createHorizontalButtonGroup(foodImageLeft: String, titleTextLeft : String, foodImageRight: String, titleTextRight : String) -> some View {
        HStack {
            createSearchPopularRecipesButton(foodImage: Image(foodImageLeft), titleText: titleTextLeft, buttonPosition: .left)
            createSearchPopularRecipesButton(foodImage: Image(foodImageRight), titleText: titleTextRight, buttonPosition: .right)
        }
        .padding(.bottom, 15)
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .previewDevice("iPhone 14 Pro Max")
            .environmentObject(FavouriteRecipesModel())
            .environmentObject(RecentRecipesModel())
    }
}

extension Color {
    static let backgroundLightColor = Color(red: 250/255, green: 250/255, blue: 251/255)
    static let searchLabelColor = Color(red: 9/255, green: 16/255, blue: 29/255)
    static let promtColor = Color(red: 116/255, green: 123/255, blue: 132/255)
    static let buttonTextColor = Color(red: 35/255, green: 38/255, blue: 43/255)
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
