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
        recipeWorker.fetchRecipes(completion: completion)
    }
}
