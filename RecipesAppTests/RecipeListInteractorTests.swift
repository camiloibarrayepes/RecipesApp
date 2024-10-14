//
//  Untitled.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import XCTest
@testable import RecipesApp

class RecipeListInteractorTests: XCTestCase {
    var interactor: RecipeListInteractor!
    var recipeWorkerMock: RecipeWorkerMock!

    override func setUp() {
        super.setUp()
        let mockNetwork = MockNetwork()
        recipeWorkerMock = RecipeWorkerMock(network: mockNetwork)
        interactor = RecipeListInteractor(recipeWorker: recipeWorkerMock)
    }

    func testFetchRecipesSuccess() {
        let expectation = XCTestExpectation(description: "Fetch recipes success")
        let recipes = MockObjects.recipesList
        recipeWorkerMock.fetchRecipesResult = .success(recipes)

        interactor.fetchRecipes { result in
            switch result {
            case .success(let recipes):
                XCTAssertEqual(recipes.count, 1)
                XCTAssertEqual(recipes.first?.name, "Battenberg Cake")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchRecipesFailure() {
        let expectation = XCTestExpectation(description: "Fetch recipes failure")
        recipeWorkerMock.fetchRecipesResult = .failure(.networkError(.generic))

        interactor.fetchRecipes { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                if case let RecipeWorkerError.networkError(networkError) = error {
                    XCTAssertEqual(networkError, .generic, "Expected network error to be of type timeout")
                } else {
                    XCTFail("Expected error to be of type RecipeWorkerError.networkError")
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }


}
