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
    @StateObject var recipesModel = RecipesModel()
    
    
    func performSearch() {
        print("Searching \(searchString)...")
        recipesModel.loadRecipes(query: searchString)
        isNavigationLinkActive = true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(searchLabel)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.searchLabelColor)
                    .padding(.horizontal, 16)
                    .padding(.top, 15)
                    .padding(.bottom, 10)
                
                HStack(spacing: 18) {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 15, height: 15)
                        .foregroundColor(.black)
                    TextField(
                        "",
                        text: $searchString,
                        onCommit: {
                            performSearch()
                        }
    //                    prompt: Text("Search here...")
    //                        .foregroundColor(.promtColor)
    //                        .font(.subheadline)
                    )
                    .foregroundColor(.black)
                    NavigationLink(
                        destination: FoundedRecipesView(recipes: recipesModel.recipes),
                        isActive: $isNavigationLinkActive,
                        label: { EmptyView() })
                    Button(action: {
                                        searchString = ""
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundLightColor)
        }
    }
    
    
    
    @ViewBuilder
    private func createSearchPopularRecipesButton(foodImage: Image, titleText: String, buttonPosition : ButtonPosition) -> some View {
        Button {
            print("Button \(titleText) is Tapped")
            recipesModel.loadRecipes(query: titleText)
            isNavigationLinkActive = true
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
    }
}

extension Color {
    static let backgroundLightColor = Color(red: 250/255, green: 250/255, blue: 251/255)
    static let searchLabelColor = Color(red: 9/255, green: 16/255, blue: 29/255)
    static let promtColor = Color(red: 116/255, green: 123/255, blue: 132/255)
    static let buttonTextColor = Color(red: 35/255, green: 38/255, blue: 43/255)
}

