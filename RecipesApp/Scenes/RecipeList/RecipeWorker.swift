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
    private let cache: CacheProtocol

    init(network: Network, cache: CacheProtocol) {
        self.network = network
        self.cache = cache
    }

    func fetchRecipes() async throws -> [Recipe] {
        let cacheKey = APIConstants.allRecipesEndpoint

        // check if the cache contains the recipes
        if let cachedRecipes = await cache.get(key: cacheKey) {
            return cachedRecipes
        }

        let url = URL(string: cacheKey)!
        do {
            let recipes: RecipesResponse = try await network.request(url: url)
            await cache.put(key: cacheKey, value: recipes.recipes) // save in cache
            return recipes.recipes
        } catch let networkError as NetworkError {
            throw RecipeWorkerError.networkError(networkError)
        } catch {
            throw RecipeWorkerError.decodingError(error)
        }
    }
}
