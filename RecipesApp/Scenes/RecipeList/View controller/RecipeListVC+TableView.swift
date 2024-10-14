//
//  RecipeListVC+TableView.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 14/10/24.
//

import UIKit

extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Returns the number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    /// Configures and returns a cell for the given index path.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
    /// Returns the height for the cells in the table view.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Cell height + space between cells
    }

    /// Handles the selection of a recipe by navigating to its detail view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        let detailVC = RecipeDetailViewController()
        detailVC.recipe = selectedRecipe // Pass the selected recipe
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
