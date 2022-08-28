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
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLAbel = GFBodyLabel(textAlign: .center)
    
    //MARK: -Properties
    var userName:String!
    var viewList:[UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewList = [headerView,itemViewOne,itemViewTwo,dateLAbel]
        
        configureViewControler()
        layoutUI()
        getUserInfo()
        }
    
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func configureViewControler(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemGray6
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUser(for: userName) {[weak self] (result) in
            guard let self = self else{return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(chilVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(chilVC: GFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(chilVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
                    self.dateLAbel.text = "Github since \(user.createdAt.convertToDate()?.converToCustomDateFormat() ?? "N/A")"
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
            }
        }
    
    func layoutUI(){
        for i in viewList {
            view.addSubview(i)
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding:CGFloat = 20
        let itemHeight:CGFloat = 140
        
      
        
       
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLAbel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLAbel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLAbel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLAbel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    func add(chilVC:UIViewController,to containerView:UIView){
        //addChild(viewController:..) metod şu anki viewControlumuza child olarak bir vc eklememizi sağlar
        addChild(chilVC)
        containerView.addSubview(chilVC.view)
        chilVC.view.frame = containerView.bounds
        //eğer child ile yeni bir Vc eklerseniz didMove(toParent:self) metodunu çağırmalısınız.
        chilVC.didMove(toParent: self)
    }

}
