//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 18.08.2022.
//

import UIKit

class FavoritesListVC: GFDataLoadingViewController {
    
    //MARK: - Views
    let tableView = UITableView()
    
    //MARK: - Properties
    var favorites:Followers = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        getFavorites()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
        tableView.reloadData()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
    
    func getFavorites(){
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let favorites):
                if favorites.isEmpty{
                    self.showEmtpyStateView(with: "You have not any favorite user.\nAdd one user.", in: self.view)
                }else{
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        //Belirtilen alt görünümü öneçıkarmak için kullanılan metot
                        //Eğer favorimiz yok emptyStateView gösterdik ekranda daha sonra favori eklediğimizde tbleView listesini göstermemiz gerekir burada tableView ı öne getirmemiz gerek .
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
               
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
}
extension FavoritesListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId, for: indexPath) as! FavoriteCell
        let item = favorites[indexPath.row]
        cell.set(favorite: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = self.favorites[indexPath.row]
        let destVC = FollowersVC(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let favorite = self.favorites[indexPath.row]
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            PersistanceManager.updateWith(favorite: favorite, actionType: .remove) {[weak self] error in
                guard let self = self else{return}
                guard let error = error else{return}
                self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.localizedDescription, buttonTitle: "Ok")
                        
                
            }
        }
    }
    
    
}
