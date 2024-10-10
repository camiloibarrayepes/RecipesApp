//
//  RecipeListPresenter.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import Foundation

class RecipeListPresenter {
    private weak var view: RecipeListView?
    private let interactor: RecipeListInteractor

    init(view: RecipeListView, interactor: RecipeListInteractor) {
        self.view = view
        self.interactor = interactor
    }

    func fetchRecipes() {
        interactor.fetchRecipes { [weak self] result in
            switch result {
            case .success(let recipes):
                // Mapeo de las recetas a ShortRecipe
                let shortRecipes = recipes.compactMap { self?.mapRecipe(from: $0) }
                self?.view?.displayRecipes(shortRecipes)
            case .failure(let error):
                self?.view?.showError(error)
            }
        }
    }
    
    // Modificado para recibir Recipe en lugar de un diccionario JSON
    private func mapRecipe(from recipe: Recipe) -> ShortRecipe? {
        guard let name = recipe.name,
              let cuisineString = recipe.cuisine,
              let cuisineType = CuisineType(rawValue: cuisineString),
              let photo = recipe.photoUrlSmall else {
            return nil
        }

        return ShortRecipe(name: name, cuisine: cuisineType, photoUrlSmall: photo)
    }
}

