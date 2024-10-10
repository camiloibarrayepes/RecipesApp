//
//  RecipeListViewController.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//
import UIKit

protocol RecipeListView: AnyObject {
    func displayRecipes(_ recipes: [Recipe])
    func showError(_ error: Error)
}

class RecipeListViewController: UIViewController, RecipeListView {

    private var recipes: [Recipe] = []
    private let tableView = UITableView()
    
    var presenter: RecipeListPresenter! // El presentador
    
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
        presenter.fetchRecipes() // Llama a fetchRecipes aquí
    }
    
    private func setupUI() {
        // Configurar la barra de navegación para el título grande
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Recipes" // Título en la barra de navegación
        view.backgroundColor = .white

        // Botón de refrescar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshRecipes))
        
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

    // Implementación del método de la vista para mostrar recetas
    func displayRecipes(_ recipes: [Recipe]) {
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
    
    // Este método detecta el desplazamiento para ajustar el tamaño del título
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 0 {
            // Cuando se hace scroll hacia arriba, el título se achica
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Cuando se hace scroll hacia abajo, el título vuelve a grande
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}

