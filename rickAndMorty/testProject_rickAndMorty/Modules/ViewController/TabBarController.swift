//
//  TabBarController.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 06.11.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        UITabBar.appearance().tintColor = .black
        self.viewControllers = [mainViewController(), favoritesViewController()]
    }
    
    func mainViewController() -> UINavigationController {
        let mainVC = MainViewController()
        mainVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        return UINavigationController(rootViewController: mainVC)
    }
    
    func favoritesViewController() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
}
