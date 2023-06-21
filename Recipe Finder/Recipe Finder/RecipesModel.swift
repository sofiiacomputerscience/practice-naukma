//
//  RecipesModel.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 18.06.2023.
//

import Foundation

class RecipesModel : ObservableObject {
    @Published var recipes: [Recipe] = []
    
    func loadRecipes(query : String) {
        
        let request = EdamamAPIRequest(query: query)
        guard let url = request.url else {
            return
        }
        let urlSession = URLSession(configuration: .ephemeral)
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let edamamAPIResponse = try decoder.decode(EdamamAPIResponse.self, from: data)
                    let newRecipes = edamamAPIResponse.hits.map { $0.recipe }
                    DispatchQueue.main.async {
                        self.recipes = newRecipes
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}






struct EdamamAPIRequest {
    let baseURL = "https://api.edamam.com/api/recipes/v2"
    let query: String
    let appID: String = "fdc49729"
    let appKey: String = "6d2190a787883226d837b1219cce2b7c"
    let type: String = "public"
    
    var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "q", value: query))
        queryItems.append(URLQueryItem(name: "app_id", value: appID))
        queryItems.append(URLQueryItem(name: "app_key", value: appKey))
        queryItems.append(URLQueryItem(name: "type", value: type))
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

struct EdamamAPIResponse: Codable {
    let hits: [Hit]
    let from: Int
    let to: Int
    let count: Int
    let links: Link
    
    enum CodingKeys: String, CodingKey {
            case hits, from, to, count
            case links = "_links"
        }
}

struct Hit: Codable {
    let recipe: Recipe
}

struct Link: Codable {
    let next: LinkInfo
}

struct LinkInfo: Codable {
    let href : String
    let title : String
}

struct Recipe: Codable, Identifiable, Hashable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uri == rhs.uri
    }
    
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let dietLabels: [String]
    let healthLabels: [String]
    let ingredients: [Ingredient]
    let calories: Double?
    let totalWeight: Double?
    let totalTime: Int?
    let cuisineType: [String]?
    let mealType: [String]?
    let dishType: [String]?
    let totalNutrients: AllNutrients
    let totalDaily: AllNutrients
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uri)
    }
    
    
    var id: String { // Convert the URI to an ID
        return uri.components(separatedBy: "_").last ?? uri
    }
}

struct Ingredient: Codable {
    let text: String
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
    let foodCategory: String?
    let foodId: String?
    let image: String?
}

struct AllNutrients: Codable {
    let energy: Nutrient
    let fat: Nutrient
    let carbs: Nutrient
    let protein: Nutrient

    enum CodingKeys: String, CodingKey {
        case energy = "ENERC_KCAL"
        case fat = "FAT"
        case carbs = "CHOCDF"
        case protein = "PROCNT"
    }
}



struct Nutrient: Codable {
    let label: String
    let quantity: Double
    let unit: String
}
