//
//  RecipeStorageManager.swift
//  Recipe Finder
//
//  Created by Vladislav Stolyarov on 23.06.2023.
//

import Foundation

enum Const {
    static let fileWithLikedRecipesName = "liked_recipes.json"
    static let fileWithRecentRecipesName = "recent_recipes.json"
}

func saveLikedRecipeToDisk(_ data: RecipeModel) {
    do {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        let jsonData = try encoder.encode(data)
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        
        let fileURL = documentsDirectory.appendingPathComponent(Const.fileWithLikedRecipesName)
        
        
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                        fileHandle.seekToEndOfFile()
                        fileHandle.write(jsonData)
                        fileHandle.write("\n".data(using: .utf8)!)
                        fileHandle.closeFile()
                } else {
                    try jsonData.write(to: fileURL)
                }
                
                print("Success saving of liked!")
            } catch {
                print("Error saving data to file: \(error.localizedDescription)")
            }
}

func saveRecentRecipeToDisk(_ data: RecipeModel) {
    do {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        let jsonData = try encoder.encode(data)
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        
        let fileURL = documentsDirectory.appendingPathComponent(Const.fileWithRecentRecipesName)
        
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                        fileHandle.seekToEndOfFile()
                        fileHandle.write(jsonData)
                        fileHandle.write("\n".data(using: .utf8)!)
                        fileHandle.closeFile()
                } else {
                    try jsonData.write(to: fileURL)
                }
                
                print("Success saving of recent!")
            } catch {
                print("Error saving data to file: \(error.localizedDescription)")
            }
}



func loadLikedRecipesFromDisk() -> [RecipeModel] {
    var loadedRecipes: [RecipeModel] = []
    do {
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentsDirectory.appendingPathComponent(Const.fileWithLikedRecipesName)
        
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            print("File does not exist at path: \(fileURL)")
            return []
        }
        
        let jsonData = try String(contentsOf: fileURL)
        let lines = jsonData.split(separator: "\n")
        if jsonData.isEmpty {
            print("File at path \(fileURL) is empty.")
            return []
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        var data: [RecipeModel] = []
        for line in lines {
                    if let lineData = line.data(using: .utf8),
                       let recipeModel = try? decoder.decode(RecipeModel.self, from: lineData) {
                        data.append(recipeModel)
                    }
                }
        print("Liked recipes loaded succesfully!")
        loadedRecipes = data
        
    } catch {
        print("Error loading data from file: \(error.localizedDescription)")
    }
    
    return loadedRecipes
}

func loadRecentRecipesFromDisk() -> [RecipeModel] {
    var loadedRecipes: [RecipeModel] = []
    do {
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentsDirectory.appendingPathComponent(Const.fileWithRecentRecipesName)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            print("File does not exist at path: \(fileURL)")
            return []
        }
        
        let jsonData = try String(contentsOf: fileURL)
        let lines = jsonData.split(separator: "\n")
        if jsonData.isEmpty {
            print("File at path \(fileURL) is empty.")
            return []
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        var data: [RecipeModel] = []
        for line in lines {
                    if let lineData = line.data(using: .utf8),
                       let recipeModel = try? decoder.decode(RecipeModel.self, from: lineData) {
                        data.append(recipeModel)
                    }
                }
        print("Recent recipes loaded succesfully!")
        
        loadedRecipes = data.reversed()
        
    } catch {
        print("Error loading data from file: \(error.localizedDescription)")
    }
    
    return loadedRecipes
}



func deleteLikedRecipeFromDisk(_ recipeToDelete: RecipeModel) {
    do {
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentsDirectory.appendingPathComponent(Const.fileWithLikedRecipesName)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            print("File does not exist at path: \(fileURL)")
            return
        }
        
        let jsonData = try String(contentsOf: fileURL)
        let lines = jsonData.split(separator: "\n")
        if jsonData.isEmpty {
            print("File at path \(fileURL) is empty.")
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        var data: [RecipeModel] = []
        for line in lines {
                    if let lineData = line.data(using: .utf8),
                       let recipe = try? decoder.decode(RecipeModel.self, from: lineData) {
                        if recipe.id != recipeToDelete.id {
                        data.append(recipe)
                        }
                    }
                }
        
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                    fileHandle.truncateFile(atOffset: 0)
                    for post in data {
                        let postData = try JSONEncoder().encode(post)
                        fileHandle.write(postData)
                        fileHandle.write("\n".data(using: .utf8)!)
                    }
                    fileHandle.closeFile()
                } else {
                    let jsonData = try JSONEncoder().encode(data)
                    try jsonData.write(to: fileURL)
                }
        
        print("Success deleting of data!")
        
    } catch {
        print("Error deleting data from file: \(error.localizedDescription)")
    }
}

func deleteRecentRecipeFromDisk() {
    do {
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentsDirectory.appendingPathComponent(Const.fileWithRecentRecipesName)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            print("File does not exist at path: \(fileURL)")
            return
        }
        
        let jsonData = try String(contentsOf: fileURL)
        let lines = jsonData.split(separator: "\n")
        if jsonData.isEmpty {
            print("File at path \(fileURL) is empty.")
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        var data: [RecipeModel] = []
        for line in lines {
                    if let lineData = line.data(using: .utf8),
                       let recipe = try? decoder.decode(RecipeModel.self, from: lineData) {
                        data.append(recipe)
                    }
                }
        data.removeFirst()
        
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                    fileHandle.truncateFile(atOffset: 0)
                    for post in data {
                        let postData = try JSONEncoder().encode(post)
                        fileHandle.write(postData)
                        fileHandle.write("\n".data(using: .utf8)!)
                    }
                    fileHandle.closeFile()
                } else {
                    let jsonData = try JSONEncoder().encode(data)
                    try jsonData.write(to: fileURL)
                }
        
        print("Success deleting of data!")
        
    } catch {
        print("Error deleting data from file: \(error.localizedDescription)")
    }
}

func deleteParticularRecentRecipeFromDisk(_ recipeToDelete: RecipeModel) {
    do {
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentsDirectory.appendingPathComponent(Const.fileWithRecentRecipesName)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            print("File does not exist at path: \(fileURL)")
            return
        }
        
        let jsonData = try String(contentsOf: fileURL)
        let lines = jsonData.split(separator: "\n")
        if jsonData.isEmpty {
            print("File at path \(fileURL) is empty.")
            return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        var data: [RecipeModel] = []
        for line in lines {
                    if let lineData = line.data(using: .utf8),
                       let recipe = try? decoder.decode(RecipeModel.self, from: lineData) {
                        if recipe.id != recipeToDelete.id {
                        data.append(recipe)
                        }
                    }
                }
        
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                    fileHandle.truncateFile(atOffset: 0)
                    for post in data {
                        let postData = try JSONEncoder().encode(post)
                        fileHandle.write(postData)
                        fileHandle.write("\n".data(using: .utf8)!)
                    }
                    fileHandle.closeFile()
                } else {
                    let jsonData = try JSONEncoder().encode(data)
                    try jsonData.write(to: fileURL)
                }
        
        print("Success deleting of data!")
        
    } catch {
        print("Error deleting data from file: \(error.localizedDescription)")
    }
}



class RecipeStorageManager {
    enum Const {
        static let fileWithLikedRecipesName = "liked_recipes.json"
        static let fileWithRecentRecipesName = "recent_recipes.json"
    }

    func testingSaveLikedRecipeToDisk(_ data: RecipeModel) {
        saveLikedRecipeToDisk(data)
    }

    func testingSaveRecentRecipeToDisk(_ data: RecipeModel) {
        saveRecentRecipeToDisk(data)
    }

    func testingLoadLikedRecipesFromDisk() -> [RecipeModel] {
        return loadLikedRecipesFromDisk()
    }

    func testingLoadRecentRecipesFromDisk() -> [RecipeModel] {
        return loadRecentRecipesFromDisk()
    }

    func testingDeleteLikedRecipeFromDisk(_ recipeToDelete: RecipeModel) {
        deleteLikedRecipeFromDisk(recipeToDelete)
    }

    func testingDeleteRecentRecipeFromDisk(_ recipeToDelete: RecipeModel) {
        deleteParticularRecentRecipeFromDisk(recipeToDelete)
    }
    
}

