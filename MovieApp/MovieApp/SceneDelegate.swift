//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import UIKit
import API


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieViewController = storyboard.instantiateViewController(identifier: "MovieViewController") as! MovieViewController
        
        let movieViewModel = MovieViewModel(networkManager: NetworkManager())
        movieViewController.viewModel = movieViewModel
        
        let movieNavigationController = UINavigationController(rootViewController: movieViewController)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().largeContentTitle = "Movie"
        movieNavigationController.navigationBar.prefersLargeTitles = true
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [movieNavigationController]
        
        let tabItemMovies = UITabBarItem(title: "Movies", image: UIImage(named: "anasayfa-x25"), tag: 0)
        movieNavigationController.tabBarItem = tabItemMovies
        
        UITabBar.appearance().barStyle = .black
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().tintColor = .white
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
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

