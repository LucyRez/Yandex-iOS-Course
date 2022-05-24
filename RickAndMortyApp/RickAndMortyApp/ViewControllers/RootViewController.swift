//
//  RootViewController.swift
//  RickAndMortyApp
//
//  Created by Ludmila Rezunic on 11.05.2022.
//

import UIKit

final class RootViewController: UITabBarController {

    private var appState = StateController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        
        setViewControllers([makeHomeViewController(), makeSearchViewController(), makeFavouritesViewController(),], animated: false)

    }
    
    
}


private extension RootViewController{
    func makeSearchViewController() -> UIViewController{
        let content = SearchViewController(state: appState)
        content.tabBarItem = .init(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return content
    }
    
    func makeFavouritesViewController() -> UIViewController{
        let container = UINavigationController(rootViewController: FavoritesViewController(state: appState))
        container.tabBarItem = .init(title: "", image: UIImage(systemName: "heart"), tag: 0)
        return container
    }
    
    
    func makeHomeViewController() -> UIViewController{
        let content = UINavigationController(rootViewController: HomeViewController())
        
        content.tabBarItem = .init(title: "", image: UIImage(systemName: "house"), tag: 0)
        return content
    }
}
