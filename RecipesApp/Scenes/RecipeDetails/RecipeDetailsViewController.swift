//
//  RecipeDetailsViewController.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import UIKit
import Foundation
import Kingfisher // Asegúrate de tener este import para cargar imágenes de URLs

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    
    private let recipeContainerView = UIView()
    private let recipeImageView = UIImageView()
    private let titleLabel = UILabel()
    private let cuisineLabel = UILabel()
    private let placeholderImage = UIImage(named: "placeholder")
    
    private let youtubeButton = CustomButton(title: "YouTube Link", image: UIImage(systemName: "link"), target: nil, action: nil)
    private let sourceButton = CustomButton(title: "Source Link", image: UIImage(systemName: "globe"), target: nil, action: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        recipeContainerView.backgroundColor = .white
        recipeContainerView.layer.cornerRadius = 10
        recipeContainerView.layer.shadowColor = UIColor.gray.cgColor
        recipeContainerView.layer.shadowOpacity = 0.5
        recipeContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        recipeContainerView.layer.shadowRadius = 4
        
        view.addSubview(recipeContainerView)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        cuisineLabel.font = UIFont.systemFont(ofSize: 16)
        cuisineLabel.numberOfLines = 0
        cuisineLabel.textAlignment = .center
        cuisineLabel.textColor = .gray
        
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        
        recipeContainerView.addSubview(titleLabel)
        recipeContainerView.addSubview(cuisineLabel)
        recipeContainerView.addSubview(recipeImageView)
        
        // Configurar constraints para la vista contenedora
        recipeContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            recipeContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recipeContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            recipeContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        
        // Configurar constraints para los subviews dentro de la vista contenedora
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cuisineLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: recipeContainerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: recipeContainerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: recipeContainerView.trailingAnchor, constant: -16),
            
            cuisineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            cuisineLabel.leadingAnchor.constraint(equalTo: recipeContainerView.leadingAnchor, constant: 16),
            cuisineLabel.trailingAnchor.constraint(equalTo: recipeContainerView.trailingAnchor, constant: -16),
            
            recipeImageView.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 16),
            recipeImageView.leadingAnchor.constraint(equalTo: recipeContainerView.leadingAnchor, constant: 16),
            recipeImageView.trailingAnchor.constraint(equalTo: recipeContainerView.trailingAnchor, constant: -16),
            recipeImageView.bottomAnchor.constraint(equalTo: recipeContainerView.bottomAnchor, constant: -16),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor)
        ])
        
        // Añadir el botón de YouTube y el botón de source
        view.addSubview(youtubeButton)
        view.addSubview(sourceButton)
        
        // Configurar constraints para los botones
        NSLayoutConstraint.activate([
            youtubeButton.topAnchor.constraint(equalTo: recipeContainerView.bottomAnchor, constant: 16),
            youtubeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            youtubeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sourceButton.topAnchor.constraint(equalTo: youtubeButton.bottomAnchor, constant: 16),
            sourceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sourceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Añadir acciones a los botones
        youtubeButton.addTarget(self, action: #selector(youtubeButtonTapped), for: .touchUpInside)
        sourceButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
    }
    
    @objc private func youtubeButtonTapped() {
        guard let recipe = recipe, let youtubeUrl = recipe.youtubeUrl else { return }
        
        if let url = URL(string: youtubeUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func sourceButtonTapped() {
        guard let recipe = recipe, let sourceUrl = recipe.sourceUrl else { return }
        
        if let url = URL(string: sourceUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    private func configureView() {
        guard let recipe = recipe else { return }
        
        titleLabel.text = recipe.name
        cuisineLabel.text = recipe.cuisine
        
        if let photoUrl = recipe.photoUrlLarge, let url = URL(string: photoUrl) {
            recipeImageView.kf.setImage(with: url, placeholder: placeholderImage)
        } else {
            recipeImageView.image = placeholderImage
        }
    }
}
