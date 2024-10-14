//
//  RecipeWorkerMock.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import XCTest
@testable import RecipesApp

class RecipeWorkerMock: RecipeWorker {
    var fetchRecipesResult: Result<[Recipe], RecipeWorkerError>?

    init(network: Network) {
        let mockCache = MockCache()
        super.init(network: network, cache: mockCache)
    }

    override func fetchRecipes() async throws -> [Recipe] {
        if let result = fetchRecipesResult {
            switch result {
            case .success(let recipes):
                return recipes
            case .failure(let error):
                throw error
            }
        }
        throw RecipeWorkerError.networkError(NetworkError.generic)
    }
}
