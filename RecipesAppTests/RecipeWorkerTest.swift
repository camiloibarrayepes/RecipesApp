//
//  RecipeWorkerTest.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 11/10/24.
//

import XCTest
@testable import RecipesApp

actor MockCache: CacheProtocol {
    private var storage: [String: [Recipe]] = [:]

    func put(key: String, value: [Recipe]) async {
        storage[key] = value
    }
    
    func get(key: String) async -> [Recipe]? {
        print("Cache get called for key: \(key)")
        return storage[key]
    }
}

class RecipeWorkerTests: XCTestCase {
    var worker: RecipeWorker!
    var mockNetwork: MockNetwork!
    var mockCache: MockCache!
    
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetwork()
        mockCache = MockCache()
        worker = RecipeWorker(network: mockNetwork, cache: mockCache)
    }
    
    func testFetchRecipesSuccess() async throws {
        let recipe = Recipe(
            cuisine: "British",
            name: "Battenberg Cake",
            photoUrlLarge: "https://example.com/large.jpg",
            photoUrlSmall: "https://example.com/small.jpg",
            sourceUrl: "https://example.com",
            uuid: "123-abc",
            youtubeUrl: "https://youtube.com/watch?v=test"
        )
        let response = RecipesResponse(recipes: [recipe])
        mockNetwork.result = .success(response)
        
        let recipes = try await worker.fetchRecipes()
        
        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.name, "Battenberg Cake")
    }
    
    func testFetchRecipesNetworkError() async {
        mockNetwork.result = .failure(NetworkError.generic)
        
        do {
            _ = try await worker.fetchRecipes()
            XCTFail("Expected network error but got success")
        } catch let error as RecipeWorkerError {
            switch error {
            case .networkError(let networkError):
                XCTAssertEqual(networkError, .generic, "Expected network error to be of type generic")
            default:
                XCTFail("Expected network error but got a different error")
            }
        } catch {
            XCTFail("Expected network error but got a different error type")
        }
    }
    
    func testFetchRecipesDecodingError() async {
        mockNetwork.result = .failure(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Test decoding error")))
        
        do {
            _ = try await worker.fetchRecipes()
            XCTFail("Expected decoding error but got success")
        } catch let error as RecipeWorkerError {
            switch error {
            case .decodingError(let decodingError as DecodingError):
                XCTAssertNotNil(decodingError, "Expected decoding error")
            default:
                XCTFail("Expected decoding error but got a diferente error")
            }
        } catch {
            XCTFail("Expected decoding error but got a different error type")
        }
    }
    
    func testFetchRecipesUsesCache() async throws {
        let recipe = Recipe(
            cuisine: "British",
            name: "Cached Recipe",
            photoUrlLarge: "https://example.com/large.jpg",
            photoUrlSmall: "https://example.com/small.jpg",
            sourceUrl: "https://example.com",
            uuid: "cached-uuid",
            youtubeUrl: "https://youtube.com/watch?v=cached"
        )
        
        // Insertar receta en la caché simulada
        print("Inserting recipe into mock cache")
        await mockCache.put(key: APIConstants.allRecipesEndpoint, value: [recipe])
        
        // Intentar obtener la receta desde la caché
        print("Attempting to fetch recipes from cache")
        let cachedRecipes = await mockCache.get(key: APIConstants.allRecipesEndpoint)
        
        // Verificar que las recetas obtenidas sean correctas
        print("Recipes fetched from cache: \(String(describing: cachedRecipes))")
        XCTAssertEqual(cachedRecipes?.count, 1)
        XCTAssertEqual(cachedRecipes?.first?.name, "Cached Recipe")
        
        // Verificar que el worker también obtiene recetas de la caché
        let recipesFromWorker = try await worker.fetchRecipes()
        XCTAssertEqual(recipesFromWorker.count, 1)
        XCTAssertEqual(recipesFromWorker.first?.name, "Cached Recipe")
    }
}
