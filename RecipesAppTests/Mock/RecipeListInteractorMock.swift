//
//  RecipeListInteractorMock.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 11/10/24.
//

import XCTest
@testable import RecipesApp

// Mock for RecipeListInteractor
class RecipeListInteractorMock: RecipeListInteractor {
    var fetchRecipesResult: Result<[Recipe], RecipeWorkerError>?

    override func fetchRecipes(completion: @escaping (Result<[Recipe], RecipeWorkerError>) -> Void) {
        if let result = fetchRecipesResult {
            completion(result)
        }
    }
}
