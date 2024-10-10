//
//  RecipeListViewController.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import UIKit

protocol RecipeListView: AnyObject {
    func displayRecipes(_ recipes: [ShortRecipe])
    func showError(_ error: Error)
}

class RecipeListViewController: UIViewController {

    private var recipes: [ShortRecipe] = []
    private let tableView = UITableView()
    
    var presenter: RecipeListPresenter! // El presentador
    private var sortType: SortType = .none // Controlador del tipo de orden

    // Definición de los tipos de ordenamiento disponibles
    enum SortType {
        case alphabeticalAscending
        case alphabeticalDescending
        case cuisineAlphabetical
        case none
    }

    // Inicializador que acepta el presentador
    init(presenter: RecipeListPresenter?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        DispatchQueue.main.async {
            self.presenter.fetchRecipes() // Llama a fetchRecipes aquí
        }
    }
    
    private func setupUI() {
        // Configurar la barra de navegación para el título grande
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Recipes" // Título en la barra de navegación
        view.backgroundColor = .white

        // Botón de refrescar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(refreshRecipes))
        
        // Botón de filtro a la izquierda
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .plain, target: self, action: #selector(showSortOptions))

        // Agregar el TableView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupTableView() {
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    @objc private func refreshRecipes() {
        presenter.fetchRecipes()
    }
    
    @objc private func showSortOptions() {
        // Presentar un ActionSheet con las opciones de ordenamiento
        let actionSheet = UIAlertController(title: "Sort Options", message: "Select how you want to sort the recipes", preferredStyle: .actionSheet)
        
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
        
        // Presentar el ActionSheet
        self.present(actionSheet, animated: true, completion: nil)
    }

    private func sortRecipes(by sortType: SortType) {
        switch sortType {
        case .alphabeticalAscending:
            recipes.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .alphabeticalDescending:
            recipes.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedDescending }
        case .cuisineAlphabetical:
            recipes.sort { $0.cuisine.rawValue.localizedCaseInsensitiveCompare($1.cuisine.rawValue) == .orderedAscending }
        case .none:
            break
        }
        
        // Recargar la tabla después de ordenar
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension RecipeListViewController: RecipeListView {
    // Implementación del método de la vista para mostrar recetas
    func displayRecipes(_ recipes: [ShortRecipe]) {
        self.recipes = recipes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // Implementación del método para mostrar errores
    func showError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Altura de la celda + espacio entre celdas
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        let detailVC = RecipeDetailViewController()
        detailVC.recipe = selectedRecipe // Pasar la receta seleccionada
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
