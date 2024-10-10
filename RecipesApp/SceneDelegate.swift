//
//  SceneDelegate.swift
//  RecipesApp
//
//  Created by Camilo Ibarra on 9/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // Crear las instancias necesarias
        let network = Network()
        let recipeWorker = RecipeWorker(network: network) // Instancia del worker
        let interactor = RecipeListInteractor(recipeWorker: recipeWorker) // Instancia del interactor
        
        // Inicializar el RecipeListViewController sin el presentador inicialmente
        let recipeListVC = RecipeListViewController(presenter: nil) // Crear la vista sin el presentador inicialmente
        
        // Inicializar el presentador pasando la vista y el interactor
        let presenter = RecipeListPresenter(view: recipeListVC, interactor: interactor)
        
        // Asignar el presentador a la vista
        recipeListVC.presenter = presenter
        
        // Embebecer RecipeListViewController en un UINavigationController
        let navigationController = UINavigationController(rootViewController: recipeListVC)
        
        // Establecer el NavigationController como controlador raíz
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

