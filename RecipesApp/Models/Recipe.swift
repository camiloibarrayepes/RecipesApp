//
//  Recipe.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

struct Recipe: Decodable {
    let cuisine: String?
    let name: String?
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let uuid: String?
    let youtubeUrl: String?

    // Computed property to check if the recipe is valid
    var isValid: Bool {
        return name != nil && cuisine != nil
    }

    // Usar CodingKeys para mapear los nombres de las propiedades
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case uuid
        case youtubeUrl = "youtube_url"
    }
}

struct ShortRecipe {
    let name: String
    let cuisine: CuisineType
    let photoUrlSmall: String?
}
