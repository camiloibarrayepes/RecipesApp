//
//  RecipeListPresenterTests.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import XCTest
@testable import RecipesApp

class RecipeListPresenterTests: XCTestCase {
    var presenter: RecipeListPresenter!
    var viewMock: RecipeListViewMock!
    var interactorMock: RecipeListInteractorMock!
    var recipeWorkerMock: RecipeWorkerMock!

    override func setUp() {
        super.setUp()
        viewMock = RecipeListViewMock()
        let mockNetwork = MockNetwork()
        recipeWorkerMock = RecipeWorkerMock(network: mockNetwork) 
        interactorMock = RecipeListInteractorMock(recipeWorker: recipeWorkerMock)
        presenter = RecipeListPresenter(view: viewMock, interactor: interactorMock)
    }

    func testFetchRecipesSuccess() {
        
        let recipes = MockObjects.recipesList
        interactorMock.fetchRecipesResult = .success(recipes)

        presenter.fetchRecipes()

        XCTAssertTrue(viewMock.displayRecipesCalled)
        XCTAssertEqual(viewMock.recipes?.first?.name, "Battenberg Cake")
    }

    func testFetchRecipesFailure() {
        interactorMock.fetchRecipesResult = .failure(RecipeWorkerError.networkError(NetworkError.generic))

        presenter.fetchRecipes()

        XCTAssertTrue(viewMock.showErrorCalled)
    }
}
