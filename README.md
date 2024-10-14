# RecipesApp

<img src="https://i.ibb.co/CBDChC0/DALL-E-2024-10-14-12-56-05-A-modern-and-vibrant-app-icon-for-a-recipe-application-featuring-a-styliz.png" alt="Recipe App Icon" width="120" height="120">

**RecipesApp** is an iOS application that allows users to search and explore recipes. The app performs a `fetch` of recipes from an API, displays them in a user-friendly interface, and allows users to view the details of each recipe upon selection.

## Features

- **Fetch Recipes**: Retrieves recipes from an API and displays them in a list.
- **Recipe Details**: Allows users to view the details of each selected recipe.
- **Optimized Caching**: Implements an LRU (Least Recently Used) cache to improve performance.
- **Image Loading**: Uses [Kingfisher](https://github.com/onevcat/Kingfisher) for efficient image loading and caching, imported via Swift Package Manager (version 8.0.3).
- **Unit Testing**: Includes unit tests to ensure code quality.
- **VIP Architecture**: Implements VIP (View-Interactor-Presenter) architecture for better code organization.
- **Async/Await and Actors**: Utilizes `async/await` for asynchronous handling and `actors` for safe concurrent access management.

## Requirements

- Xcode 13 or later
- iOS 16.0 or later

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your_username/RecipesApp.git
   cd RecipesApp
2. **Open the project in Xcode**:
   
    ```bash
    open RecipesApp.xcodeproj
4. **Install dependencies: Kingfisher is imported via Swift Package Manager. 
To add it, go to File > Swift Packages > Add Package Dependency, and enter the following URL:**:
    ```bash
    https://github.com/onevcat/Kingfisher.git
## Usage
1. Run the application: Select a simulator or a real device in Xcode and run the application.
2. Explore Recipes: The app will display a list of recipes. You can select any recipe to see more details.

## Testing
   ```bash
xcodebuild -scheme RecipesApp -destination "platform=iOS Simulator,name=iPhone 16,OS=latest" test -only-testing:RecipesAppTests
```

## Contributing

Contributions are welcome! This project is open-source, and if you'd like to contribute, please follow these steps:

- **Fork the repository**.
- **Create a new branch**:
  ```bash
    git checkout -b feature/new-feature
    ```
- **Make your changes and commit them**:
  ```bash
    git commit -m 'Add new feature'
    ```
- **Push to the branch**:
  ```bash
    git push origin feature/new-feature
    ```
- **Open a pull request**.

### Reporting Issues

If you find a bug or have a feature request, please open an issue in the repository, providing as much detail as possible.
