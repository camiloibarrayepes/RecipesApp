//
//  RecipeCell.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import UIKit

class RecipeCell: UITableViewCell {
    private let containerView = UIView() // Contenedor para la celda
    private let nameLabel = UILabel()
    private let cuisineLabel = UILabel()
    private let recipeImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configurar el contenedor
        containerView.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1) // Azul pastel
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        
        // Configurar la imagen
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 8

        // Crear el stack view
        let stackView = UIStackView(arrangedSubviews: [nameLabel, cuisineLabel])
        stackView.axis = .vertical
        stackView.spacing = 4 // Espacio entre los textos
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Añadir subviews
        containerView.addSubview(recipeImageView)
        containerView.addSubview(stackView)
        contentView.addSubview(containerView)
        
        // Configurar constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            recipeImageView.heightAnchor.constraint(equalToConstant: 80),
            recipeImageView.widthAnchor.constraint(equalTo: recipeImageView.heightAnchor), // Hacer la imagen cuadrada
            recipeImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            recipeImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: -10),
        ])
    }
    
    func configure(with recipe: Recipe) {
        nameLabel.text = recipe.name
        cuisineLabel.text = recipe.cuisine
        
        // Cargar la imagen de manera eficiente
        if let photoUrl = recipe.photoUrlSmall, let url = URL(string: photoUrl) {
            recipeImageView.loadImage(from: url)
        } else {
            recipeImageView.image = UIImage(named: "placeholder")
        }
    }
}



// Extensión para cargar imágenes de manera asincrónica
extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}


