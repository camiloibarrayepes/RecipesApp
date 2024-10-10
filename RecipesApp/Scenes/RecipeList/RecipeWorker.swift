//
//  RecipeWorker.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import Foundation

enum RecipeWorkerError: Error {
    case networkError(Error)
    case decodingError(Error)
}

class RecipeWorker {
    func fetchRecipes(completion: @escaping (Result<[Recipe], RecipeWorkerError>) -> Void) {
        // Implementación de la llamada a la API
        // Al realizar la llamada a la API, usa RecipeWorkerError para manejar los errores

        let url = URL(string: APIConstants.allRecipesEndpoint)! // Ajusta la URL según sea necesario

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.decodingError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned."]))))
                return
            }
            
            do {
                let recipes = try JSONDecoder().decode(RecipesResponse.self, from: data)
                completion(.success(recipes.recipes))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }
        
        task.resume()
    }
}
