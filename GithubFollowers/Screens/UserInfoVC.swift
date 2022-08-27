//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 27.08.2022.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var userName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemGray6
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        NetworkManager.shared.getUser(for: userName) {[weak self] (result) in
            guard let self = self else{return}
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
   }
    override func viewWillAppear(_ animated: Bool) {
        print(userName!)
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }



}
