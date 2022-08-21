//
//  FollowersVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 19.08.2022.
//

import UIKit

class FollowersVC: UIViewController {
    var username:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollower(for: username, page: 1) { (result) in
            switch result{
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
               
            }
        }
 }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }

}
