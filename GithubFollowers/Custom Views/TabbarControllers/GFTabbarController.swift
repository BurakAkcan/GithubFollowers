//
//  GFTabbarController.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 30.08.2022.
//

import UIKit

class GFTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
        viewControllers = [createSearchNC(),createFavNC()]

    }
    
    
    //MARK: Create Navigation Controllers
    
    func createSearchNC()->UINavigationController{
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    func createFavNC()->UINavigationController{
        let favoriteVC = FavoritesListVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteVC)
    }
    
}
