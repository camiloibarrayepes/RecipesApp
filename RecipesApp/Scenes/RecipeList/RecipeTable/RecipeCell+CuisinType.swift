//
//  RecipeCell+String.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import Foundation
import UIKit

extension String {
    func colorForCuisine() -> UIColor {
        switch self {
        case "Malaysian":
            return UIColor(red: 173/255, green: 124/255, blue: 47/255, alpha: 0.5) // Verde claro
        case "British":
            return UIColor(red: 70/255, green: 130/255, blue: 180/255, alpha: 0.5) // Azul acero
        case "Italian":
            return UIColor(red: 255/255, green: 69/255, blue: 0/255, alpha: 0.5) // Rojo tomate
        case "American":
            return UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 0.5) // Azul Dodger
        case "French":
            return UIColor(red: 255/255, green: 182/255, blue: 193/255, alpha: 0.5) // Rosa claro
        case "Canadian":
            return UIColor(red: 34/255, green: 139/255, blue: 34/255, alpha: 0.5) // Verde bosque
        case "Tunisian":
            return UIColor(red: 255/255, green: 140/255, blue: 0/255, alpha: 0.5) // Naranja oscuro
        default:
            return UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 0.5) // Azul pastel por defecto
        }
    }
}
