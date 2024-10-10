//
//  RecipeCell+String.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import UIKit

enum CuisineType: String, CaseIterable {
    case malaysian = "Malaysian"
    case british = "British"
    case italian = "Italian"
    case american = "American"
    case french = "French"
    case canadian = "Canadian"
    case tunisian = "Tunisian"

    // Método para obtener un color asociado a cada tipo de cocina
    var color: UIColor {
        switch self {
        case .malaysian:
            return UIColor(red: 255/255, green: 223/255, blue: 186/255, alpha: 1) // Ejemplo de color
        case .british:
            return UIColor(red: 186/255, green: 255/255, blue: 213/255, alpha: 1) // Ejemplo de color
        case .italian:
            return UIColor(red: 224/255, green: 200/255, blue: 255/255, alpha: 1) // Ejemplo de color
        case .american:
            return UIColor(red: 200/255, green: 224/255, blue: 255/255, alpha: 1) // Ejemplo de color
        case .french:
            return UIColor(red: 255/255, green: 200/255, blue: 200/255, alpha: 1) // Ejemplo de color
        case .canadian:
            return UIColor(red: 255/255, green: 255/255, blue: 200/255, alpha: 1) // Ejemplo de color
        case .tunisian:
            return UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1) // Ejemplo de color
        }
    }
}
