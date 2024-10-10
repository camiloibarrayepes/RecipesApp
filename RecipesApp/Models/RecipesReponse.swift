//
//  RecipesReponse.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import Foundation

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}
