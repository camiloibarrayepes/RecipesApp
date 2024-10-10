//
//  RecipeListInteractor.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import Foundation

class RecipeListInteractor {
    private let recipeWorker: RecipeWorker

    init(recipeWorker: RecipeWorker) {
        self.recipeWorker = recipeWorker
    }

    func fetchRecipes(completion: @escaping (Result<[Recipe], RecipeWorkerError>) -> Void) {
        Task {
            do {
                let recipes = try await recipeWorker.fetchRecipes()
                completion(.success(recipes))
            } catch let error as RecipeWorkerError {
                completion(.failure(error))
            } catch {
                completion(.failure(.networkError(error as! NetworkError)))
            }
        }
    }

}
