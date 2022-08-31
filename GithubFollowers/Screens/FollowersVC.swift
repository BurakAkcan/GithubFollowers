//
//  FollowersVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import UIKit

protocol FollowerListVCDelegate:AnyObject{
    func didRequestFollowers(for userName:String)
}

class FollowersVC: GFDataLoadingViewController {
    
    enum Section{
        case main
    }
    
    var collectionView:UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    
    var username:String!
    var followers:Followers = []
    var filteredFollower:Followers = []
    var page:Int  = 1
    var hasMoreFollowers:Bool = true
    var isSearching:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollection()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    init(username:String){
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGreen
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClick))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    
    func configureCollection(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelpers.createThreeColumnFlowLayout(in: view))
        //Yukarıda collecitonView ı tanımlamsak view.addSubview komut satırı hata verecek çünkü collecitionView ı oluşturmedik
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    
    
    func getFollowers(username:String,page:Int){
        showLoadingView()
        NetworkManager.shared.getFollower(for: username, page: page) { [weak self] result in
            
            guard let self = self else{return}
            self.dismissLoading()
            switch result{
            case .success(let followers):
                
                if followers.count < 100 {self.hasMoreFollowers = false}
                
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty{
                    let message = "\(username) user doesn't have any followers.😞"
                    DispatchQueue.main.async {
                        self.showEmtpyStateView(with: message, in: self.view)
                    }
                   
                }
                
                //We update collectionView like reloadData() fonk.
                self.updateData(listFollower: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
               
            }
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: itemIdentifier)
            return cell
            
        })
    }
    func updateData(listFollower:Followers){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(listFollower)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    @objc func addButtonClick(){
        showLoadingView()
        NetworkManager.shared.getUser(for: username) { [weak self] (result) in
            guard let self = self else{return}
            self.dismissLoading()
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarURL:  user.avatarURL)
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
                    guard let self = self else{return}
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Succes", message: "You have succesfully favorited \(user.login) 🎉", buttonTitle: "Good")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")

                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
            
    }
        
    }
    
}

extension FollowersVC:UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        print("Offset = \(offsetY)")
        print("contentHeight = \(contentHeight)")
        print("height \(height)")
        if offsetY > contentHeight - height{
            guard hasMoreFollowers else{return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tapArray = isSearching ? filteredFollower : followers
        let follower = tapArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.delegate = self
        destVC.userName = follower.login   
        //Navigation ekledik viewControllerımıza
        let navController = UINavigationController(rootViewController: destVC)
       
        present(navController, animated: true, completion: nil)
        
        
    }
}

extension FollowersVC:UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
              !filter.isEmpty else{
            filteredFollower.removeAll()
            isSearching = false 
            updateData(listFollower: followers)
            return}
        isSearching = true
        filteredFollower = followers.filter({$0.login.lowercased().contains(filter.lowercased())})
        updateData(listFollower: filteredFollower)
 }
    //Arama kımında cancel dedğimizde sadece aradığımız kelimeeleri içeren kişiler geliyor liste eski haline dönmüyor bunun için cancel buton fonk kullanmalıyız tabiki UISearchBarDelegate protocolunu extend etmemeiz lazım viewımıza.
    
}

extension FollowersVC:FollowerListVCDelegate{
    func didRequestFollowers(for userName: String) {
        self.username = userName
        title = userName
        page = 1
        followers.removeAll()
        filteredFollower.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: userName, page: page)
        
    }
    
    
}




//Notes

/* -Diffable data source iki veri arasındaki farklı otomatik hesaplayıp table view ve collection viewin öğelerini güncellemenin kolay yoludur. Table viewin öğelerini güncellerken ekstra bir koda ihtiyaç duymadan animasyon ekler.
 -Diffable data sourceda indexPath yerine indentifier item ve sectionlar kullanmanız gerekmektedir.
- Itemlar için oluşturduğunuz nesnelerde identifier unique olmak zorundadır. Bunuda sağlamak için Hashable protokolünden faydalanılır. Section yapısını ise enum araçılığı ile çözülebilir. Enumlarda Hashable protokolü otomatik olarak uygulanmaktadır.
 - Snapshot => Diffable data source sınıfında görüntülenmesi istenen veri snapshot haline getirilip ve apply metodu araçılığı ile bildirilir.
 
 SearchController
 -Önce searchController tanımlıyoruz
 -SearchController a searchUpdateResult delegate yapısını uyguluyouz ve ViewControllera bunu implemente ediyoruz
 -navigationItem.searchController a oluşturduğumuz searchControllerı ekliyoruz
 
 
 */
