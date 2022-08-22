//
//  FollowersVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import UIKit

class FollowersVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var collectionView:UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    
    var username:String!
    var followers:Followers = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureViewController()
        configureCollection()
        getFollowers()
        configureDataSource()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollection(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelpers.createThreeColumnFlowLayout(in: view))
        //Yukarıda collecitonView ı tanımlamsak view.addSubview komut satırı hata verecek çünkü collecitionView ı oluşturmedik
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        }
    
    
    
    func getFollowers(){
        NetworkManager.shared.getFollower(for: username, page: 1) { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let followers):
                self.followers = followers
                
                //We update collectionView like reloadData() fonk.
                self.updateData()
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
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
}




//Notes

/* -Diffable data source iki veri arasındaki farklı otomatik hesaplayıp table view ve collection viewin öğelerini güncellemenin kolay yoludur. Table viewin öğelerini güncellerken ekstra bir koda ihtiyaç duymadan animasyon ekler.
 -Diffable data sourceda indexPath yerine indentifier item ve sectionlar kullanmanız gerekmektedir.
- Itemlar için oluşturduğunuz nesnelerde identifier unique olmak zorundadır. Bunuda sağlamak için Hashable protokolünden faydalanılır. Section yapısını ise enum araçılığı ile çözülebilir. Enumlarda Hashable protokolü otomatik olarak uygulanmaktadır.
 - Snapshot => Diffable data source sınıfında görüntülenmesi istenen veri snapshot haline getirilip ve apply metodu araçılığı ile bildirilir.
 
 */
