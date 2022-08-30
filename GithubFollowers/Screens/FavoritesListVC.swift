//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 18.08.2022.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let favorites):
               print(favorites)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

   

}
