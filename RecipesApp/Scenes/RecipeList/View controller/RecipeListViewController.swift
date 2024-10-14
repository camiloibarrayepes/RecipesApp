//
//  RecipeListViewController.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import UIKit

/// Protocol defining the methods for displaying recipes or showing errors.
protocol RecipeListView: AnyObject {
    func displayRecipes(_ recipes: [Recipe])
    func showError(_ error: Error)
}

/// Controller for displaying a list of recipes with sorting and navigation features.
class RecipeListViewController: UIViewController, RecipeListView {

    var recipes: [Recipe] = []
    private let tableView = UITableView()
    
    var presenter: RecipeListPresenter!
    private var sortType: SortType = .none

    /// Custom initializer for the RecipeListViewController.
    /// - Parameter presenter: The presenter responsible for fetching data.
    init(presenter: RecipeListPresenter?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        DispatchQueue.main.async {
            self.presenter.fetchRecipes()
        }
    }
    
    /// Configures the user interface, including navigation bar and table view layout.
    private func setupUI() {
        // Configure navigation bar for large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Recipes" // Navigation bar title
        view.backgroundColor = .white

        // Refresh button on the right side of the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .plain,
            target: self,
            action: #selector(refreshRecipes)
        )
        
        // Sort filter button on the left side of the navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3.decrease"),
            style: .plain,
            target: self,
            action: #selector(showSortOptions)
        )

        // Add the table view to the view hierarchy
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    /// Configures the table view, including data source, delegate, and cell registration.
    private func setupTableView() {
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    /// Refreshes the list of recipes by calling the presenter to fetch them again.
    @objc private func refreshRecipes() {
        presenter.fetchRecipes()
    }
    
    /// Reloads the table view data asynchronously on the main thread.
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    /// Displays the fetched recipes in the table view.
    /// - Parameter recipes: An array of Recipe objects to display.
    func displayRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
        reloadData()
    }

    /// Handles errors by printing the error message.
    /// - Parameter error: The error encountered while fetching recipes.
    func showError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

