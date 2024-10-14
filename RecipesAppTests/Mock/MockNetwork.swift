//
//  MockNetwork.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import XCTest
@testable import RecipesApp

class MockNetwork: Network {
    var result: Result<RecipesResponse, Error>?

    override func request<T: Decodable>(url: URL) async throws -> T {
        switch result {
        case .success(let response):
            // Intentamos convertir el resultado al tipo T esperado
            if let typedResponse = response as? T {
                return typedResponse
            } else {
                throw MockNetworkError.typeMismatch(expected: T.self, actual: type(of: response))
            }
        case .failure(let error):
            throw error
        default:
            throw MockNetworkError.unexpectedResultType
        }
    }
}

enum MockNetworkError: Error {
    case typeMismatch(expected: Any.Type, actual: Any.Type)
    case unexpectedResultType
}
