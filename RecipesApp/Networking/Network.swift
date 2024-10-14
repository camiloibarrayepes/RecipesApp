//
//  Network.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailed(Error)
    case noData
    case decodingFailed(Error)
    case generic

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.noData, .noData):
            return true
        case (.generic, .generic):
            return true
        case let (.requestFailed(errorA), .requestFailed(errorB)):
            return (errorA as NSError).domain == (errorB as NSError).domain && (errorA as NSError).code == (errorB as NSError).code
        case let (.decodingFailed(errorA), .decodingFailed(errorB)):
            return (errorA as NSError).domain == (errorB as NSError).domain && (errorA as NSError).code == (errorB as NSError).code
        default:
            return false
        }
    }
}

class Network {
    init() {}

    // Método genérico para hacer solicitudes de red utilizando async/await
    func request<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        // Verifica el estado de la respuesta
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(NSError(domain: "InvalidResponse", code: 0, userInfo: nil))
        }

        // Decodifica el JSON
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}

