//
//  RecipeCell.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell {
    private let containerView = UIView() // Contenedor para la celda
    private let nameLabel = UILabel()
    private let cuisineLabel = UILabel()
    private let recipeImageView = UIImageView()
    private let placeholderImage = UIImage(named: "placeholder") // Asegúrate de que la imagen de placeholder esté en tus assets

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 8
        // Configurar la imagen
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 8
        recipeImageView.image = placeholderImage // Establecer el placeholder inicialmente

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

    func configure(with recipe: ShortRecipe) {
        // Configurar el nombre con tamaño de fuente más grande y en negrita
        nameLabel.text = recipe.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        
        // Configurar la cocina
        cuisineLabel.text = recipe.cuisine.rawValue
        
        // Cambiar el color del contenedor según el tipo de cuisine
        containerView.backgroundColor = recipe.cuisine.color
        
        // Cargar la imagen de manera eficiente usando Kingfisher
        if let photoUrl = recipe.photoUrlSmall, let url = URL(string: photoUrl) {
            recipeImageView.kf.setImage(with: url, placeholder: placeholderImage)
        } else {
            recipeImageView.image = placeholderImage // Mostrar placeholder si no hay URL
        }
    }
}



