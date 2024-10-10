//
//  RecipeDetailsViewController.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import UIKit
import Kingfisher

class RecipeDetailViewController: UIViewController {
    
    var recipe: ShortRecipe?
    
    private let recipeImageView = UIImageView()
    private let titleLabel = UILabel()
    private let youtubeLinkLabel = UILabel()
    private let placeholderImage = UIImage(named: "placeholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Configurar la imagen
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        
        // Configurar el título
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        // Configurar el link de YouTube
        youtubeLinkLabel.font = UIFont.systemFont(ofSize: 16)
        youtubeLinkLabel.textColor = .blue
        youtubeLinkLabel.isUserInteractionEnabled = true
        
        // Añadir subviews
        view.addSubview(recipeImageView)
        view.addSubview(titleLabel)
        view.addSubview(youtubeLinkLabel)
        
        // Configurar constraints
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        youtubeLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recipeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            youtubeLinkLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            youtubeLinkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureView() {
        guard let recipe = recipe else { return }
        
        titleLabel.text = recipe.name
        
        // Cargar la imagen
        if let photoUrl = recipe.photoUrlSmall, let url = URL(string: photoUrl) {
            recipeImageView.kf.setImage(with: url, placeholder: placeholderImage)
        } else {
            recipeImageView.image = placeholderImage
        }
        
        // Configurar el link de YouTube
        youtubeLinkLabel.text = "Watch on YouTube"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openYouTubeLink))
        youtubeLinkLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openYouTubeLink() {
        //guard let recipe = recipe, let urlString = recipe.youtubeLink, let url = URL(string: urlString) else { return }
        //UIApplication.shared.open(url)
    }
}
