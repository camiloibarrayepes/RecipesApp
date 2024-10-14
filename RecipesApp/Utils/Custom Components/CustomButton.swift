//
//  CustomButton.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 10/10/24.
//

import UIKit

class CustomButton: UIButton {
    
    init(title: String, image: UIImage?, target: Any?, action: Selector?) {
        super.init(frame: .zero)
        setupButton(title: title, image: image, target: target, action: action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String, image: UIImage?, target: Any?, action: Selector?) {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.baseForegroundColor = .systemBlue
        configuration.image = image
        configuration.imagePadding = 8
        
        self.configuration = configuration
        
        if let target = target, let action = action {
            self.addTarget(target, action: action, for: .touchUpInside)
        }

        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
