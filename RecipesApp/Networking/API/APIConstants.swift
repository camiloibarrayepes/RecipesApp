//
//  APIConstants.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net"
    
    // Endpoints
    static let allRecipesEndpoint = "\(baseURL)/recipes.json"
    static let malformedDataEndpoint = "\(baseURL)/recipes-malformed.json"
    static let emptyDataEndpoint = "\(baseURL)/recipes-empty.json"
    
    // Timeout
    static let timeout: TimeInterval = 30.0
    
    // Add other constants related to API as needed
}
