//
//  RecipeListVC+SortType.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 14/10/24.
//

import UIKit
import Foundation

extension RecipeListViewController {

    /// Enumeration defining the available sorting options.
    enum SortType {
        case alphabeticalAscending
        case alphabeticalDescending
        case cuisineAlphabetical
        case none
    }
    
    /// Displays an ActionSheet with sorting options for the recipe list.
    @objc func showSortOptions() {
        let actionSheet = UIAlertController(
            title: "Sort Options",
            message: "Select how you want to sort the recipes",
            preferredStyle: .actionSheet
        )
        
        let alphabeticalAscending = UIAlertAction(title: "Alphabetical (A-Z)", style: .default) { _ in
            self.sortRecipes(by: .alphabeticalAscending)
        }
        
        let alphabeticalDescending = UIAlertAction(title: "Alphabetical (Z-A)", style: .default) { _ in
            self.sortRecipes(by: .alphabeticalDescending)
        }
        
        let cuisineAlphabetical = UIAlertAction(title: "Cuisine (A-Z)", style: .default) { _ in
            self.sortRecipes(by: .cuisineAlphabetical)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(alphabeticalAscending)
        actionSheet.addAction(alphabeticalDescending)
        actionSheet.addAction(cuisineAlphabetical)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }

    
    /// Sorts the list of recipes based on the selected sorting type.
    /// - Parameter sortType: The sorting criteria to be applied.
    func sortRecipes(by sortType: SortType) {
        switch sortType {
        case .alphabeticalAscending:
            recipes.sort { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedAscending }
        case .alphabeticalDescending:
            recipes.sort { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedDescending }
        case .cuisineAlphabetical:
            recipes.sort { $0.cuisine?.localizedCaseInsensitiveCompare($1.cuisine ?? "") == .orderedAscending }
        case .none:
            break
        }
        
        // Reload the table view after sorting
        reloadData()
    }

}
