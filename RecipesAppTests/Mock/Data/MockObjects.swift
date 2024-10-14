//
//  TestData.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 11/10/24.
//

import XCTest
@testable import RecipesApp

struct MockObjects {
    static let recipe = Recipe(
        cuisine: "British",
        name: "Battenberg Cake",
        photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/ec1b84b1-2729-4547-99db-5e0b625c0356/large.jpg",
        photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/ec1b84b1-2729-4547-99db-5e0b625c0356/large.jpg",
        sourceUrl: "https://www.source.com",
        uuid: "891a474e-91cd-4996-865e-02ac5facafe3",
        youtubeUrl: "https://www.youtube.com/watch?v=aB41Q7kDZQ0"
    )
    
    static let recipesList = [recipe]
}
