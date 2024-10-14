//
//  RecipeListViewControllerTests.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 11/10/24.
//

import XCTest
@testable import RecipesApp

class RecipeListViewControllerTests: XCTestCase {
    var viewController: RecipeListViewController!
    var presenterMock: RecipeListPresenterMock!
    var viewMock: RecipeListViewMock!
    var interactorMock: RecipeListInteractorMock!
    var recipeWorkerMock: RecipeWorkerMock!

    override func setUp() {
        super.setUp()
        viewMock = RecipeListViewMock()
        let mockNetwork = MockNetwork()
        recipeWorkerMock = RecipeWorkerMock(network: mockNetwork)
        interactorMock = RecipeListInteractorMock(recipeWorker: recipeWorkerMock)
        presenterMock = RecipeListPresenterMock(view: viewMock, interactor: interactorMock)
        viewController = RecipeListViewController(presenter: presenterMock)
    }

    func testViewDidLoadFetchesRecipes() {
        let expectation = XCTestExpectation(description: "Fetch recipes called")

        presenterMock.fetchRecipesCalled = false
        viewController.loadViewIfNeeded()

        DispatchQueue.main.async {
            XCTAssertTrue(self.presenterMock.fetchRecipesCalled, "Expected fetchRecipes to be called on viewDidLoad")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testDisplayRecipes() {
        let recipes = MockObjects.recipesList
        viewController.displayRecipes(recipes)

        XCTAssertEqual(viewController.recipes.count, 1)
        XCTAssertEqual(viewController.recipes.first?.name, "Battenberg Cake")
    }

    func testShowError() {
        viewController.showError(NSError(domain: "TestError", code: 0, userInfo: nil))
    }
}
