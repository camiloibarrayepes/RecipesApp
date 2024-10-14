//
//  RecipeListViewMock.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 11/10/24.
//

import XCTest
@testable import RecipesApp


// Mock for RecipeListView
class RecipeListViewMock: RecipeListView {
    var displayRecipesCalled = false
    var showErrorCalled = false
    var recipes: [Recipe]?

    func displayRecipes(_ recipes: [Recipe]) {
        displayRecipesCalled = true
        self.recipes = recipes
    }

    func showError(_ error: Error) {
        showErrorCalled = true
    }
}
