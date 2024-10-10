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
                self?.view?.displayRecipes(recipes)
            case .failure(let error):
                self?.view?.showError(error)
            }
        }
    }
}


