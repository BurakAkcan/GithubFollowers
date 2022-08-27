//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Burak AKCAN on 27.08.2022.
//

import UIKit

class UserInfoVC: UIViewController {
    
    //MARK: -Views
    let headerView = UIView()
    
    //MARK: -Properties
    var userName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemGray6
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        layoutUI()
        
        NetworkManager.shared.getUser(for: userName) {[weak self] (result) in
            guard let self = self else{return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(chilVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
                
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
    
    func layoutUI(){
        view.addSubview(headerView)
        
       
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }

    func add(chilVC:UIViewController,to containerView:UIView){
        addChild(chilVC)
        containerView.addSubview(chilVC.view)
        chilVC.view.frame = containerView.bounds
        chilVC.didMove(toParent: self)
    }

}
