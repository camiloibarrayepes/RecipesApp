//
//  RecipeWorker.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import Foundation

enum RecipeWorkerError: Error {
    case networkError(NetworkError)
    case decodingError(Error)
}

class RecipeWorker {
    private let network: Network
    private var cache: LRUCache
    
    init(network: Network, cacheCapacity: Int = 10) {
        self.network = network
        self.cache = LRUCache(capacity: cacheCapacity)
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        let cacheKey = APIConstants.allRecipesEndpoint
        
        // Verificar si las recetas están en caché
        if let cachedRecipes = cache.get(key: cacheKey) {
            return cachedRecipes // Devolver recetas desde la caché
        }
        
        let url = URL(string: cacheKey)!
        do {
            let recipes: RecipesResponse = try await network.request(url: url)
            cache.put(key: cacheKey, value: recipes.recipes) // Almacenar recetas en caché
            return recipes.recipes
        } catch let networkError as NetworkError {
            throw RecipeWorkerError.networkError(networkError)
        } catch {
            throw RecipeWorkerError.decodingError(error)
        }
    }
}
