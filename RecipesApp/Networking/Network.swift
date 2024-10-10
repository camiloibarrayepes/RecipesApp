//
//  Network.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case noData
    case decodingFailed(Error)
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

