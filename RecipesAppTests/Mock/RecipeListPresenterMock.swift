//
//  RecipeListPresenterMock.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 14/10/24.
//

import XCTest
@testable import RecipesApp

// Mock for RecipeListPresenter
class RecipeListPresenterMock: RecipeListPresenter {
    var fetchRecipesCalled = false

    override func fetchRecipes() {
        fetchRecipesCalled = true
    }
}
